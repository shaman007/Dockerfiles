from pathlib import Path
import json
import os
import shutil
import subprocess
import tempfile
import unittest

ROOT = Path(__file__).resolve().parents[1]


class BuildSigningTests(unittest.TestCase):
    def exercise(self, fail=False, invalid=False):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            (root/'app').mkdir()
            (root/'app/Dockerfile').write_text('FROM scratch\n')
            (root/'public.pem').write_text('mock public key')
            tools = root/'bin'
            tools.mkdir()
            mock = '''#!/usr/bin/env python3
import json,os,pathlib,sys
args=sys.argv[1:]
with open(os.environ['MOCK_LOG'],'a') as log:log.write(json.dumps([pathlib.Path(sys.argv[0]).name]+args)+'\\n')
if '--digestfile' in args:
 pathlib.Path(args[args.index('--digestfile')+1]).write_text('invalid' if os.environ['MOCK_BAD_DIGEST']=='1' else 'sha256:'+'a'*64)
if pathlib.Path(sys.argv[0]).name=='cosign' and args[0]=='sign' and os.environ['MOCK_FAIL_SIGN']=='1':sys.exit(1)
'''
            for name in ['podman','cosign']:
                path=tools/name
                path.write_text(mock)
                path.chmod(0o755)
            env=dict(os.environ,PATH=str(tools)+os.pathsep+os.environ['PATH'],
                PULL='0',LOGIN='0',PLATFORMS='linux/amd64',CONTAINER_ENGINE='podman',
                SIGN='1',COSIGN_KEY='/mock-key',COSIGN_PUBLIC_KEY=str(root/'public.pem'),
                MOCK_LOG=str(root/'calls.jsonl'),MOCK_FAIL_SIGN=str(int(fail)),MOCK_BAD_DIGEST=str(int(invalid)))
            result=subprocess.run(['bash',str(ROOT/'build.sh'),'app'],cwd=root,env=env,capture_output=True,text=True)
            return result, [json.loads(line) for line in (root/'calls.jsonl').read_text().splitlines()]

    def test_signs_and_verifies_both_pushed_digests(self):
        result,calls=self.exercise()
        self.assertEqual(result.returncode,0,result.stderr)
        sign=[c for c in calls if c[:2]==['cosign','sign']]
        verify=[c for c in calls if c[:2]==['cosign','verify']]
        self.assertEqual(len(sign),2)
        self.assertEqual(len(verify),2)
        self.assertTrue(all(c[-1].endswith('@sha256:'+'a'*64) for c in sign+verify))
        self.assertTrue(all('--key' in c for c in sign+verify))

    def test_failed_sign_stops_before_latest_publication(self):
        result,calls=self.exercise(fail=True)
        self.assertNotEqual(result.returncode,0)
        self.assertEqual(len([c for c in calls if c[:3]==['podman','manifest','push']]),1)
        self.assertFalse(any(c[:2]==['cosign','verify'] for c in calls))

    def test_invalid_digest_never_reaches_signer(self):
        result,calls=self.exercise(invalid=True)
        self.assertNotEqual(result.returncode,0)
        self.assertFalse(any(c[0]=='cosign' for c in calls))


if __name__=='__main__':unittest.main()
