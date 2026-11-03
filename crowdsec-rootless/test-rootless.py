#!/usr/bin/env python3
"""Integration test: no production volumes, credentials or ports are used."""
import argparse
import pathlib
import subprocess
import time
import re
import tempfile
import shutil
import uuid
parser=argparse.ArgumentParser(description='Exercise rootless CrowdSec startup and SQLite migration with disposable local volumes')
parser.add_argument('--image',default='localhost/crowdsec-rootless:v1.8.1-rootless.1')
parser.add_argument('--lapi-startup-script',required=True,type=pathlib.Path)
args=parser.parse_args()
image=args.image;prefix='codex-crowdsec-rootless-'+uuid.uuid4().hex[:8];pod=prefix+'-test'
work=pathlib.Path(tempfile.mkdtemp(prefix='crowdsec-rootless-image-check-'))
script=work/'docker_start.sh';script.write_text(args.lapi_startup_script.read_text());script.chmod(0o644)
vols={key:prefix+'-'+key for key in ['config','data','shared']}
def call(args,check=True,timeout=180):
 p=subprocess.run(['podman',*args],capture_output=True,text=True,timeout=timeout)
 if check and p.returncode:
  # Never print command arguments or raw application logs; test keys stay inside volumes.
  raise RuntimeError('Podman '+args[0]+' failed: '+re.sub(r'[A-Za-z0-9+/=_-]{40,}','[redacted]',p.stderr[-500:]))
 return p
common=['--pod',pod,'--cap-drop=ALL','--security-opt=no-new-privileges','--image-volume=ignore','--pull=never']
lapi_script='''umask 077
if [ ! -s /probe/registration-token ]; then head -c 64 /dev/urandom | od -An -tx1 | tr -d ' \\n' > /probe/registration-token; fi
export REGISTRATION_TOKEN="$(cat /probe/registration-token)"
export CS_LAPI_SECRET="$REGISTRATION_TOKEN"
cp -nR /staging/etc/crowdsec/* /etc/crowdsec_data/
cat > /etc/crowdsec_data/config.yaml.local <<'CONFIG'
db_config:
  db_path: /var/lib/crowdsec/data/crowdsec-rootless.db
api:
  server:
    auto_registration:
      enabled: true
      token: "${REGISTRATION_TOKEN}"
      allowed_ranges:
      - "127.0.0.1/32"
CONFIG
ln -s /etc/crowdsec_data /etc/crowdsec
exec bash /docker_start.sh
'''
def wait_for(name,command):
 for _ in range(90):
  if call(['exec',name,'sh','-ceu',command],check=False,timeout=10).returncode==0:return
  running=call(['inspect',name,'--format','{{.State.Running}}']).stdout.strip()
  if running!='true':
   logs=call(['logs','--tail','20',name],check=False); print(re.sub(r'[A-Za-z0-9+/=_-]{32,}','[redacted]',logs.stdout+logs.stderr),flush=True); raise RuntimeError(name+' exited before readiness')
  time.sleep(1)
 raise RuntimeError(name+' readiness timeout')
def phase(number):
 lapi=prefix+'-lapi';agent=prefix+'-agent'
 call(['run','--rm',*common,'--entrypoint=/usr/local/bin/crowdsec-rootless-prepare-database','-v',vols['data']+':/var/lib/crowdsec/data',image])
 call(['run','-d','--name',lapi,*common,'--entrypoint=sh','-v',str(script)+':/docker_start.sh:ro,Z','-v',vols['config']+':/etc/crowdsec_data','-v',vols['data']+':/var/lib/crowdsec/data','-v',vols['shared']+':/probe','-e','LOCAL_API_URL=http://127.0.0.1:8080','-e','DISABLE_AGENT=true','-e','DISABLE_ONLINE_API=true','-e','CUSTOM_HOSTNAME=rootless-check-lapi','-e','METRICS_PORT=6061',image,'-ceu',lapi_script])
 wait_for(lapi,'nc -z 127.0.0.1 8080');print('Phase',number,'LAPI started',flush=True)
 username='rootless-check-agent-'+str(number)
 register='export REGISTRATION_TOKEN="$(cat /probe/registration-token)"; ln -s /staging/etc/crowdsec /etc/crowdsec; cscli lapi register --machine '+username+' -u http://127.0.0.1:8080 --token "$REGISTRATION_TOKEN" >/dev/null 2>&1; cp /etc/crowdsec/local_api_credentials.yaml /tmp_config/local_api_credentials.yaml'
 if number==1:register+='; cp /tmp_config/local_api_credentials.yaml /tmp_config/original_credentials.yaml'
 call(['run','--rm',*common,'--entrypoint=sh','-v',vols['shared']+':/probe','-v',vols['shared']+':/tmp_config',image,'-ceu',register]);print('Phase',number,'registration succeeded',flush=True)
 call(['run','-d','--name',agent,*common,'--entrypoint=sh','-v',vols['shared']+':/tmp_config','-e','DISABLE_LOCAL_API=true','-e','DISABLE_ONLINE_API=true','-e','CROWDSEC_BYPASS_DB_VOLUME_CHECK=true','-e','LOCAL_API_URL=http://127.0.0.1:8080','-e','COLLECTIONS=crowdsecurity/traefik',image,'-ceu','cp /tmp_config/local_api_credentials.yaml /staging/etc/crowdsec/local_api_credentials.yaml; exec ./docker_start.sh'])
 wait_for(agent,'wget -q -O /dev/null http://127.0.0.1:6060/metrics')
 call(['exec',agent,'sh','-ceu','cscli lapi status >/dev/null 2>&1; wget -q -O /dev/null http://127.0.0.1:6061/metrics'])
 for name in [lapi,agent]:
  p=call(['exec',name,'sh','-ceu','test "$(id -u)" = 1000; cat /proc/1/status; test ! -w /etc/passwd; test ! -w /etc/group; test -w /etc'])
  fields={l.split(':',1)[0]:l.split(':',1)[1].strip() for l in p.stdout.splitlines() if ':' in l}
  assert fields['CapEff']=='0000000000000000' and fields['CapBnd']=='0000000000000000' and fields['NoNewPrivs']=='1' and fields['Seccomp']=='2',name
 if number>=2:call(['run','--rm',*common,'--entrypoint=sh','-v',vols['shared']+':/tmp_config:ro',image,'-ceu','cp /tmp_config/original_credentials.yaml /staging/etc/crowdsec/local_api_credentials.yaml; ln -s /staging/etc/crowdsec /etc/crowdsec; cscli lapi status >/dev/null 2>&1'])
 print('Phase',number,'UID1000 / zero capabilities / no-new-privileges / metrics / auth passed',flush=True)
 call(['stop','--time','10',agent,lapi]);call(['rm',agent,lapi])
try:
 call(['pod','create','--name',pod])
 for v in vols.values():call(['volume','create',v])
 phase(1)
 # Simulate kubelet fsGroup migration: owner remains root, group becomes 1000,
 # with group rw on files and rwx/setgid on directories. No production volumes.
 fix='mv /fixture-data/crowdsec-rootless.db /fixture-data/crowdsec.db; chown -R 0:1000 /fixture-config /fixture-data; find /fixture-config /fixture-data -type d -exec chmod 2770 {} +; find /fixture-config /fixture-data -type f -exec chmod 0660 {} +'
 call(['run','--rm','--user=0','--cap-drop=ALL','--cap-add=CHOWN,DAC_OVERRIDE,FOWNER','--entrypoint=sh','-v',vols['config']+':/fixture-config','-v',vols['data']+':/fixture-data',image,'-ceu',fix])
 phase(2);phase(3);print('EXISTING_CONFIGURATION_AND_DATABASE_PRESERVED_AND_MIGRATION_IDEMPOTENT',flush=True)
finally:
 call(['pod','rm','--force',pod],check=False)
 for v in vols.values():call(['volume','rm','--force',v],check=False)
 shutil.rmtree(work)
