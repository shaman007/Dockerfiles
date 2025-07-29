# Changelog

## 2023-07-27 – `f21ec04` by Andrey Bondarenko
- **Documentation**
  - Added `README.md` file with initial content: "# Dockerfiles"

## 2023-07-27 – `300d0b3` by Andrey Bondarenko
- **Documentation Update**
  - Expanded README.md with project description and purpose.
  - Added details about PHP-FPM Dockerfile for WordPress and Nextcloud.

## 2023-07-27 – `66d821e` by Andrey Bondarenko
- **Dockerfile Enhancements**
  - Added `Dockerfile` for PHP-FPM 8.2 with extensive package installations and configurations.
  - Included installation of common PHP extensions (e.g., `pdo_mysql`, `gd`, `imagick`, `redis`, `apcu`).
  - Configured health check script and set locale to UTF-8.

- **Documentation Updates**
  - Introduced `README.md` detailing PHP-FPM usage, environment variables, and configuration options.
  - Added `LICENSE` file with MIT License terms.

- **Configuration Files**
  - Integrated default configuration files (`php.ini`, `www.conf`) for PHP-FPM.
  - Added various scripts to `/usr/local/bin/` for operational tasks.

- **Important Notes**
  - Ensure to specify custom `www.conf` if not using the default configuration to avoid conflicts.

## 2023-08-07 – `3195e7e` by Andrey Bondarenko
- **Postfix Container Setup**
  - Added `postfix/Dockerfile` for building a Postfix container based on Alpine Linux.
  - Included essential packages: `postfix`, `bash`, `rsyslog`, and others.
  - Configured entry point to run Postfix in single mode.

- **Configuration Files**
  - Introduced `postfix/etc/postfix/main_single.cf.tmpl` for Postfix configuration.
  - Added `postfix/etc/aliases` for email aliasing.

- **Documentation Updates**
  - Updated `README.md` to include Postfix container information.
  - Added `postfix/LICENSE` file with GNU General Public License v3.

- **Service Management**
  - Copied service scripts to `postfix/service/` for managing Postfix processes.

**Note:** This commit introduces a new Postfix container setup, which may require adjustments in deployment configurations.

## 2023-08-07 – `f69668a` by Andrey Bondarenko
- **Documentation Update**
  - Revised `postfix/README.md` to clarify the status of the Postfix container as "not finished yet."
  - Removed outdated information regarding scripts and Dockerfile usage.

## 2023-08-07 – `d378ede` by Andrey Bondarenko
- **Removed Files:**
  - Deleted `bodycheck` and `headercheck` files from `postfix/etc/postfix/`.

- **Updated vmailbox:**
  - Cleaned up comments in `vmailbox` file.
  - Retained catch-all entry for `@andreybondarenko.com` but removed warnings against its use.

## 2023-08-07 – `157cb9c` by Andrey Bondarenko
- **File Removal**: Deleted `postfix/etc/mail/aliases`.
- **Impact**: This file contained critical mail alias configurations, including root mail forwarding and system aliases.
- **Breaking Change**: Removal may disrupt mail delivery for root and system accounts; ensure alternative configurations are in place.

## 2023-08-07 – `db88808` by Andrey Bondarenko
- **Script Update**: 
  - Removed error handling (`set -e`) from `postfix/service/run_single`.
  - Eliminated comments regarding dynamic configuration changes to `main.cf`.
  
- **Functionality**:
  - Retained functionality for creating the virtual mailbox database with `postmap lmdb:/etc/postfix/vmailbox`. 

- **File Affected**: 
  - `postfix/service/run_single` (script execution behavior modified).

## 2023-08-07 – `8ee840a` by Andrey Bondarenko
- **Dockerfile Updates**
  - Changed entry point from `run_single` to `run` for multi-instance support.
  - Updated configuration file copy from `main_single.cf.tmpl` to `main.cf`.

- **Configuration Files**
  - Introduced new `main.cf` with basic Postfix settings.
  - Added `virtual_mailbox_domains` and `virtual_mailbox_maps` configurations for handling virtual mailboxes.

- **Service Scripts**
  - Adjusted service scripts to accommodate new configuration file structure and multi-instance operation.

## 2023-08-10 – `88a859a` by Andrey Bondarenko
- **Dovecot Integration**
  - Added `Dockerfile`, `README.md`, and `run` script for Dovecot setup.
  - Installed necessary Dovecot packages and configured logging.

- **OpenDKIM Integration**
  - Added `Dockerfile`, `README.md`, and configuration files for OpenDKIM.
  - Implemented key management with `keytable`, `signingtable`, and private key handling.
  - Configured OpenDKIM with `opendkim.conf` and logging setup.

- **Documentation Updates**
  - Updated `README.md` to include Dovecot and OpenDKIM.
  - Added specific notes on configuration and permissions for OpenDKIM.

- **File Permissions**
  - Set strict permissions for OpenDKIM configuration files to enhance security.

- **Breaking Changes**
  - New Docker images for Dovecot and OpenDKIM may require adjustments in deployment configurations.

## 2023-08-14 – `85bdb18` by Andrey Bondarenko
- **Dockerfile Updates**
  - Added `ffmpeg` to the list of installed packages in `php-fpm/Dockerfile`.

## 2023-08-21 – `2920f53` by Andrey Bondarenko
- **Documentation Update**
  - Updated comment in `dovecot/run` to reflect correct logging service: changed from "Postfix" to "Dovecot".

## 2023-08-21 – `f3bd44e` by Andrey Bondarenko
- **Dockerfile Updates:**
  - Added `/etc/opendkim_init` directory for initial configuration files.
  - Moved configuration files (`signingtable`, `keytable`, `mail.private`, `mail.txt`, `trustedhosts`) to `/etc/opendkim_init`.
  - Adjusted permissions and ownership for `/etc/opendkim` in the `run` script.

- **README.md Changes:**
  - Updated instructions regarding configuration file mounting to `/etc/opendkim_init` before container execution.

- **Run Script Enhancements:**
  - Added commands to copy files from `/etc/opendkim_init` to `/etc/opendkim` and set appropriate permissions and ownership.

**Breaking Change:** Configuration files must now be mounted to `/etc/opendkim_init` instead of directly into `/etc/opendkim`.

## 2023-08-22 – `d906666` by Andrey Bondarenko
- **Documentation Updates**
  - Added Rspamd entry to `README.md`.

- **Docker Configuration**
  - Introduced `Dockerfile` for Rspamd with Debian base.
  - Installed necessary packages: `procps`, `vim`, `telnet`, `rspamd`, `ca-certificates`, `ssl-cert`, and `syslog-ng`.
  - Configured logging to stdout for mail logs.

- **Service Scripts**
  - Created `run` script for Rspamd service management.
  - Script includes starting `syslog-ng` and `rspamd` in foreground mode.

- **New Files**
  - Added `rspamd/README.md` for basic configuration and usage notes.

## 2023-08-22 – `38b0511` by Andrey Bondarenko
- **Dockerfile Updates:**
  - Removed installation commands for `mongodb` and `xdebug`.
  - Removed SendGrid installation steps, including Postfix configuration.

- **Documentation Changes:**
  - Removed sections related to Supervisord and its configuration from `README.md`.
  - Updated PHP extensions list, removing `memcache`, `memcached`, and `mongodb`.

- **Script Removals:**
  - Deleted `newrelic.sh` and `sendgrid.sh` scripts from `php-fpm/scripts/`.

**Breaking Changes:**
- Removal of SendGrid and New Relic integration scripts may affect email routing and monitoring setups.

## 2023-11-01 – `08f80d6` by Andrey Bondarenko
- **Dovecot**:
  - Replaced `syslog-ng` with `rsyslog` in `Dockerfile` and `run` script.
  - Updated user creation to set home directory to `/var/mail/boxes/shaman007`.

- **OpenDKIM**:
  - Switched from `syslog-ng` to `rsyslog` in `Dockerfile` and `run` script.
  - Changed report address in `opendkim.conf` to `me@andreybondarenko.com`.

- **PHP-FPM**:
  - Added scripts for New Relic and SendGrid integration.
  - Updated `Dockerfile` to install Postfix and configure SendGrid for email routing.
  - Removed `LICENSE` file.

- **General**:
  - Multiple Dockerfiles updated to use `rsyslog` instead of `syslog-ng`.
  - Breaking change: `syslog-ng` is no longer supported; ensure compatibility with `rsyslog`.

## 2023-11-01 – `db00725` by Andrey Bondarenko
### CHANGELOG for Commit db00725

- **Dockerfile Updates**:
  - Removed unnecessary packages (`procps`, `vim`, `telnet`) from `dovecot`, `opendkim`, `postfix`, `rspamd`, and `rsyslog` Dockerfiles.
  - Added cleanup commands to remove `git` and unnecessary files after package installation in all Dockerfiles.

- **File Modifications**:
  - Updated `dovecot/Dockerfile`, `opendkim/Dockerfile`, `postfix/Dockerfile`, `rspamd/Dockerfile`, and `rsyslog/Dockerfile` to streamline builds and reduce image size.

- **General Improvements**:
  - Enhanced Dockerfile efficiency by minimizing installed packages and cleaning up after installations.

## 2023-11-01 – `8726fec` by Andrey Bondarenko
- **Dovecot**: 
  - Updated README to clarify features: SIEVE and SALSL added.

- **OpenDKIM**: 
  - Revised README to emphasize strict permissions and config mounting.
  - Added TODO to transition DKIM tasks to Rspamd.

- **Postfix**: 
  - Updated README to clarify that the container runs Postfix.

- **Rspamd**: 
  - Simplified README, removed mention of debug tools.

- **Rsyslog**: 
  - Added new README outlining Daemonset and Replicaset for log collection.

## 2023-11-01 – `da981b7` by Andrey Bondarenko
- **Documentation Updates**
  - Added "Rsyslog" to the list of projects in `README.md`.
- **File Changes**
  - Updated `README.md` to reflect new project inclusion.

## 2023-11-07 – `7e1f19a` by Andrey Bondarenko
- **Documentation Updates**
  - Removed references to SIEVE and SALSL from `dovecot/README.md`.
  - Removed mentions of Xdebug and Zend OPcache from `php-fpm/README.md`.

- **Scripts**
  - No changes detected in script files (`php-fpm/scripts/*.sh`).

- **Configuration**
  - No changes detected in configuration files (`postfix/etc/postfix/main.cf`).

- **Dockerfiles**
  - No changes detected in Dockerfiles (`dovecot/Dockerfile`, `rspamd/Dockerfile`).

## 2023-11-09 – `61308e5` by Andrey Bondarenko
- **Removed OpenDKIM Support**
  - Deleted `opendkim` directory and all related files: `Dockerfile`, `README.md`, `keytable`, `mail.private`, `mail.txt`, `opendkim.conf`, `run`, `signingtable`, `trustedhosts`.
  - Removed OpenDKIM references from `README.md`.

- **Cleanup**
  - Entire OpenDKIM configuration and initialization scripts removed, indicating a shift away from using OpenDKIM in the project. 

- **Breaking Change**
  - Existing configurations and setups relying on OpenDKIM will no longer function; users must migrate to alternative DKIM solutions (e.g., Rspamd).

## 2023-11-10 – `1d2ff0b` by Andrey Bondarenko
- **Build Scripts**
  - Added `build.sh` for automated Docker image builds and pushes to a registry.

- **Dovecot**
  - Removed `rsyslog` installation and related configurations from `Dockerfile` and `run` script.
  - Cleaned up unnecessary packages in `Dockerfile`.

- **Postfix**
  - Replaced `service/run` with `run` script for improved startup sequence.
  - Updated `Dockerfile` to remove `rsyslog` dependency and added `COPY` commands for better organization.

- **PHP-FPM**
  - Introduced `.env-example` for environment variable configuration.
  - Added `.gitignore` to exclude `.env` files from version control.

- **Rsyslog**
  - Updated `Dockerfile` for cleanup after installation, ensuring minimal image size. 

**Breaking Changes:**
- Removed `rsyslog` dependencies from Dovecot and Rspamd, which may affect logging configurations.

## 2023-11-11 – `abe6755` by Andrey Bondarenko
- **Removed Files:**
  - Deleted `.env-example` and `.gitignore` from `php-fpm/`.
  - Removed `Dockerfile` and `README.md` from `php-fpm/`.

- **Docker Configuration:**
  - Complete removal of the `Dockerfile` for `php-fpm`, impacting the build process and dependencies.

- **Environment Variables:**
  - All environment variable configurations related to PHP-FPM have been removed, which may affect container initialization and runtime behavior.

- **Documentation:**
  - The removal of `README.md` eliminates guidance on PHP-FPM usage and configuration.

- **Breaking Changes:**
  - Significant breaking changes due to the removal of essential configuration files and documentation; users will need to recreate or adapt their setups accordingly.

## 2023-11-13 – `2b7ff93` by Andrey Bondarenko
- **New Features:**
  - Added Dockerfiles for MySQL, PostgreSQL, and Redis CLI tools.
  - Implemented backup scripts for MySQL (`mysql-cli/backup`), PostgreSQL (`postgres-cli/backup`), and Redis (`redis-cli/backup`).

- **Configuration:**
  - Introduced `.pre-commit-config.yaml` for pre-commit hooks, including checks for trailing whitespace, YAML, JSON, and private keys.

- **Scripts:**
  - Added `run` scripts for MySQL, PostgreSQL, and Redis CLI, ensuring containers remain active.

- **Cleanup:**
  - Dockerfiles include cleanup commands to reduce image size by removing unnecessary packages and files.

- **File Permissions:**
  - Backup and run scripts are set to executable (`100755`).

- **Important Paths:**
  - Backup files are generated in the root directory with timestamps in their names.

## 2023-11-14 – `ee6e3f4` by Andrey Bondarenko
### CHANGELOG for Commit ee6e3f4

- **Dockerfile Updates**:
  - Consolidated `apt-get` commands into single lines for efficiency across multiple Dockerfiles:
    - `dovecot`, `mysql-cli`, `php`, `postfix`, `postgres-cli`, `redis-cli`, `rspamd`, `rsyslog`.
  - Removed redundant `apt-get remove -y git` commands from individual Dockerfiles.

- **File Modifications**:
  - Updated installation commands to streamline package management and cleanup processes.
  - Maintained consistent cleanup commands to reduce image size.

- **General Improvements**:
  - Enhanced readability and maintainability of Dockerfiles by reducing the number of RUN commands. 

No breaking changes were introduced in this commit.

## 2023-11-15 – `798ca17` by Andrey Bondarenko
- **Documentation Updates**
  - Updated README.md to clarify Postfix container usage and added note on `*-cli` images for backups.

- **Build Process Enhancements**
  - Changed Docker registry URL in build.sh from `registry.example.com` to `registry.andreybondarenko.com`.
  - Added build and push logging in build.sh for better visibility during Docker operations.

- **New Features**
  - Introduced `minecraft-cli/Dockerfile` for building a new Docker image based on Debian.
  - Added `minecraft-cli/backup.sh`, a comprehensive script for managing automatic backups of Minecraft servers.

- **File Structure Changes**
  - New files created: `minecraft-cli/Dockerfile` and `minecraft-cli/backup.sh`.

## 2023-11-15 – `c4006fa` by Andrey Bondarenko
- **CI/CD Integration**
  - Added GitHub Actions workflow for Docker image CI in `.github/workflows/docker-image.yml`.
  - Triggers on `push` and `pull_request` events for the `main` branch.
  - Builds Docker image using `Dockerfile` and tags it with a timestamp.

## 2023-11-21 – `01c5ec7` by Andrey Bondarenko
- **Dovecot**: 
  - Removed commented `rsyslogd` line in `dovecot/run`.

- **Minecraft CLI**:
  - Removed commented `HELLO` line in `minecraft-cli/run`.

- **PHP**:
  - Removed commented lines in `php/run`.

- **Redis CLI**:
  - Removed commented `HELLO` line in `redis-cli/run`.

- **General**:
  - Cleaned up scripts across multiple services by removing unnecessary comments.

## 2023-11-21 – `a88678c` by Andrey Bondarenko
- **New Configuration:**
  - Added `compose-dev.yaml` for development environment configuration.

- **Dockerfile Updates:**
  - Changed base image from `debian:latest` to `debian:stable-slim` in:
    - `dovecot/Dockerfile`
    - `minecraft-cli/Dockerfile`
    - `mysql-cli/Dockerfile`
    - `php/Dockerfile`
    - `postfix/Dockerfile`
    - `postgres-cli/Dockerfile`
    - `redis-cli/Dockerfile`
    - `rspamd/Dockerfile`
    - `rsyslog/Dockerfile`

- **General Improvements:**
  - Updated package installation commands to enhance efficiency and reduce image size across multiple Dockerfiles.

## 2023-11-21 – `989b547` by Andrey Bondarenko
- **Docker Improvements**
  - Switched to stable-slim container.
  - Optimized Dockerfiles and removed debug tools.
  - Created `docker-image.yml` for image management.
  - Moved to a custom, lighter PHP-FPM image.

- **Backup & Configuration**
  - Added Minecraft backup CLI image.
  - Configurations now managed as config maps for Kubernetes.
  - Added Rspamd, Dovecot, and OpenDKIM (initial commit).

- **Documentation Updates**
  - Updated various README files.
  - Cleaned up comments and documentation.

- **General Cleanup**
  - Multiple cleanup actions across Dockerfiles and scripts.

## 2023-11-21 – `7b4ffe1` by Andrey Bondarenko
- **Documentation Updates**
  - Updated `CHANGELOG.md` with recent changes.
  - Revised `README.md` for clarity and accuracy.

## 2023-11-22 – `6bc6bc0` by Andrey Bondarenko
- **Dockerfile Added**: Introduced `languagetool/Dockerfile` for building LanguageTool container.
- **Base Image**: Utilizes `debian:stable-slim`.
- **Dependencies**: Installs `default-jre`, `wget`, and `unzip` for setup.
- **LanguageTool Setup**: Downloads and unzips LanguageTool, moves to `/languagetool`.
- **Cleanup**: Removes installation tools and cleans up APT cache to reduce image size.
- **Entry Point**: Configured to run LanguageTool server on port 8081 with CORS enabled.

## 2023-11-22 – `12cbc0b` by Andrey Bondarenko
- **Dockerfile Updates:**
  - Changed installation command to `apt-get -y install` for non-interactive installs.
  - Removed downloaded LanguageTool zip file after extraction.
  - Updated directory move command to `mv -r LanguageTool-6.3 /languagetool`.

- **New Run Script:**
  - Added `run` script to `/etc/` for starting the LanguageTool server.
  - Updated `ENTRYPOINT` to execute the new script instead of directly calling Java.

- **Cleanup Enhancements:**
  - Retained cleanup commands for apt lists and temporary files.

- **Breaking Change:**
  - The entry point for the Docker container has changed from a direct Java command to a script, which may affect existing configurations relying on the previous setup.

## 2023-11-22 – `9fba969` by Andrey Bondarenko
- **Dockerfile Update**
  - Fixed command syntax in `languagetool/Dockerfile`: changed `mv -r` to `mv` for moving LanguageTool directory.
- **Dependency Management**
  - Ensured cleanup of unnecessary packages (`wget`, `unzip`) after installation.

## 2023-11-22 – `3486d8d` by Andrey Bondarenko
- **Dockerfile Updates:**
  - Split installation of LanguageTool into separate RUN commands for better layer management.
  - Removed wget and unzip in a separate RUN command to optimize image size.
  
- **File Permissions:**
  - Changed permissions of `languagetool/run` from 644 to 755, making it executable. 

- **General Maintenance:**
  - Cleaned up APT cache and temporary files to reduce image size.

## 2023-11-22 – `a8e72de` by Andrey Bondarenko
- **Docker Setup**  
  - Added `Dockerfile` for ClamAV setup based on `debian:stable-slim`.
  - Installs `clamav` and `clamav-daemon`, cleans up APT cache.

- **Run Script**  
  - Introduced `run` script to execute `freshclam` in the foreground.

- **File Locations**  
  - `clamav/Dockerfile`: New Docker configuration file.
  - `clamav/run`: New script for ClamAV initialization.

## 2023-11-22 – `8719b38` by Andrey Bondarenko
- **File Permission Update**
  - Changed file mode of `clamav/run` from `100644` to `100755` (executable).

## 2023-11-22 – `ae89625` by Andrey Bondarenko
- **Dockerfile Updates**
  - Added `RUN freshclam` to update ClamAV virus definitions.
  - Introduced `VOLUME /var/lib/clamav` for persistent storage of virus definitions.
  
- **General Maintenance**
  - Updated package management commands for better cleanup.

## 2023-11-22 – `f6e7d22` by Andrey Bondarenko
- **Dockerfile Updates**
  - Added ownership change for `/var/lib/clamav/` to `clamav:clamav`.
  
- **Run Script Modifications**
  - Corrected path for `freshclam` command (removed leading slash).
  - Added execution of `clamd` in foreground mode. 

- **Important Files**
  - `clamav/Dockerfile`
  - `clamav/run`

- **Breaking Changes**
  - Ensure `clamd` service is running alongside `freshclam` in the updated script.

## 2023-11-22 – `5a60edd` by Andrey Bondarenko
- **Dockerfile Updates:**
  - Added creation of `/var/run/clamav` directory with ownership and permissions set for `clamav`.
  - Introduced `/usr/local/share/clamav` directory with ownership adjustments.
  - Updated ownership for `/var/lib/clamav` and `/etc/clamav` to `clamav`.

- **Permissions:**
  - Set permissions of `/var/run/clamav` to `750`. 

- **General Maintenance:**
  - Cleaned up APT lists and temporary files post-installation.

## 2023-11-23 – `eb17599` by Andrey Bondarenko
- **Script Update**: Modified `clamav/run` to conditionally execute `freshclam` or `clamd` based on the `UPDATE` environment variable.
- **Execution Logic**: 
  - If `UPDATE` is not set, runs `clamd` in the foreground.
  - If `UPDATE` is set, runs `freshclam` in the foreground.
- **File Path**: Changes made in `clamav/run`.

## 2023-11-23 – `a95a7d0` by Andrey Bondarenko
- **Documentation Update**
  - Updated README.md to include a link to projects repository.
  - Added descriptions for Clamav and Language Tool in README.md.

## 2023-11-23 – `d64a686` by Andrey Bondarenko
- **CI/CD Updates**
  - Removed GitHub Actions workflow for Docker image CI from `.github/workflows/docker-image.yml`.

## 2023-11-24 – `9d07ae7` by Andrey Bondarenko
- **Dockerfile Updates**
  - Added `mb2md` package installation to `rspamd/Dockerfile`.
  - Maintained cleanup commands to optimize image size.

## 2023-11-24 – `d472f34` by Andrey Bondarenko
- **Dockerfile Added**: 
  - Created `minio-single/Dockerfile` for MinIO deployment.
  - Base image set to `debian:stable-slim`.
  - Installs MinIO from a specific Debian package.

- **Run Script Added**: 
  - Added `minio-single/run` script for starting MinIO server.
  - Implements a persistent loop to keep the container running.

- **Important Note**: 
  - New files are essential for running MinIO in a Docker environment.

## 2023-11-24 – `f5f6c34` by Andrey Bondarenko
- **File Permissions**: Changed file mode of `minio-single/run` from `100644` to `100755` (added executable permissions).

## 2023-11-24 – `413bff8` by Andrey Bondarenko
- **Script Update**: Modified `minio-single/run` to use `$MINIO_DRIVE` as a parameter for the MinIO server command.
- **Execution**: Ensured the script continues to run indefinitely after starting the server.

## 2023-11-24 – `0711686` by Andrey Bondarenko
- **Script Update**: 
  - Changed environment variable reference from `$MINIO_DRIVE` to `$MINIO-DRIVE` in `minio-single/run`.
  
- **File Permissions**: 
  - Maintained executable permissions for `minio-single/run`.

## 2023-11-24 – `38b9d2b` by Andrey Bondarenko
- **Documentation Updates**
  - Updated `README.md` for clarity and accuracy.

## 2023-11-24 – `bdd0e2e` by Andrey Bondarenko
- **Script Update**  
  - Fixed variable name in `minio-single/run`: changed `$MINIO-DRIVE` to `$MINIO_DRIVE`.  
- **File Affected**  
  - `minio-single/run` (script execution path).  
- **Behavior Change**  
  - Corrected environment variable usage for MinIO server startup.

## 2023-11-24 – `97aa0c1` by Andrey Bondarenko
- **Dockerfile Updates**:
  - Removed combined RUN command for better readability.
  - Added installation of MinIO client (`mc`) alongside MinIO server.
  - Adjusted cleanup process to remove `wget` after installation.
  
- **File Path**:
  - Modified file: `minio-single/Dockerfile`

## 2023-11-24 – `75e0b45` by Andrey Bondarenko
- **Enhancements**
  - Updated MinIO server command in `minio-single/run` to include `--console-address ":9090"` for console access.

- **File Modified**
  - `minio-single/run` - script now provides console access on port 9090.

## 2023-12-03 – `82442b4` by Andrey Bondarenko
- **Dockerfile Updates**
  - Added `ffmpeg` installation to PHP Docker image.
  - Removed `git` during cleanup to reduce image size.

## 2023-12-22 – `e6b038b` by Andrey Bondarenko
- **Configuration Updates:**
  - Added `opcache.jit_buffer_size = 128M` to `php/opcache.ini`.
  
- **Process Management Adjustments:**
  - Increased `pm.max_children` from 15 to 240 in `php/www.conf`.
  - Adjusted `pm.start_servers` from 4 to 24.
  - Updated `pm.min_spare_servers` from 1 to 12.
  - Modified `pm.max_spare_servers` from 6 to 36.
  - Set `php_value[memory_limit]` to `-1` (unlimited) from 612M.

## 2024-01-03 – `1e415c5` by Andrey Bondarenko
- **New Configuration & Scripts**
  - Added `camera/10-cgi.conf`: Lighttpd configuration for CGI.
  - Introduced `camera/run`: Bash script to keep the container alive.

- **Docker Integration**
  - Created `camera/Dockerfile`: 
    - Based on `debian:stable-slim`.
    - Installs `ffmpeg` and `lighttpd`.
    - Copies configuration and scripts into appropriate directories.
    - Sets entry point to `/etc/run`.

- **Webcam Streaming**
  - Added `camera/webcamstream`: Bash script for streaming video via `ffmpeg` from an RTSP source. 

- **File Permissions**
  - Set executable permissions for `webcamstream` script. 

- **Note**: No breaking changes identified.

## 2024-01-03 – `a9d1805` by Andrey Bondarenko
- **Dockerfile Updates**
  - Fixed Dockerfile syntax by adding continuation character (`&&`) in `RUN` command.
  - Ensured cleanup commands are executed after package installations.

## 2024-01-03 – `70622d3` by Andrey Bondarenko
- **Dockerfile Updates**
  - Removed redundant `sudo` command from the `RUN` instruction.
  - Ensured cleanup commands remain intact after package installation.

## 2024-01-03 – `8c43d99` by Andrey Bondarenko
- **Configuration Updates**
  - Added CGI module configuration in `camera/10-cgi.conf`.
  - Configured URL handling for `/cgi-bin/` requests.

- **Dockerfile Modifications**
  - Copied `10-cgi.conf` to Lighttpd configuration directory.
  - Ensured executable permissions for `/etc/run` script.

- **New Functionality**
  - Introduced CGI support for webcam streaming via `/var/www/cgi-bin/`.

## 2024-01-03 – `bc883ce` by Andrey Bondarenko
- **Configuration Changes**
  - Added environment variables `USER` and `PASSWORD` to `setenv.add-request-header` in `camera/10-cgi.conf`.

- **Dockerfile Updates**
  - Changed configuration file copy path from `/etc/lighttpd/conf-available/10-cgi.conf` to `/etc/lighttpd/conf-enabled/10-cgi.conf` in `camera/Dockerfile`. 

- **Cleanup**
  - Minor cleanup in Dockerfile: retained apt cache cleanup commands.

## 2024-01-03 – `756e3ba` by Andrey Bondarenko
- **Configuration Changes:**
  - Removed `setenv.add-request-header` settings from `camera/10-cgi.conf`.

- **Script Modifications:**
  - Updated `camera/run` to include `lighttpd` startup command.
  - Added `env` command to `camera/run` for environment variable debugging.

- **Streaming Adjustments:**
  - Modified `ffmpeg` command in `camera/webcamstream` to use `-rtsp_transport tcp` and corrected password syntax. 

- **Important Files:**
  - `camera/10-cgi.conf`, `camera/run`, `camera/webcamstream` are affected. 

- **Breaking Changes:**
  - Removal of request header settings may impact authentication handling.

## 2024-01-03 – `8404b4b` by Andrey Bondarenko
- **Environment Configuration**:
  - Added user and password environment variables to `/etc/env` in `camera/run`.
  
- **Webcam Stream Handling**:
  - Sourced `/etc/env` in `camera/webcamstream` for environment variable access.
  - Fixed RTSP URL formatting in `camera/webcamstream` to include `@` for user/password separation.

**Important Files**: 
- `camera/run`
- `camera/webcamstream`

**Breaking Change**: 
- The script now relies on `/etc/env` for user and password, which must be correctly set for functionality.

## 2024-01-03 – `45e812a` by Andrey Bondarenko
- **Script Updates**:
  - Changed environment variable echoing format in `camera/run`:
    - Updated `echo @USER` to `echo "USER=$USER"`
    - Updated `echo @PASSWORD` to `echo "PASSWORD=$PASSWORD"`
- **File Affected**: `camera/run` - ensure compatibility with environment variable usage.

## 2024-01-03 – `acee1a2` by Andrey Bondarenko
- **Configuration Updates:**
  - Added `mod_auth` and `mod_authn_file` to `camera/10-cgi.conf`.
  - Configured basic authentication for `/admin` with user `shaman007`.

- **Docker Enhancements:**
  - Updated `camera/Dockerfile` to copy `huser` to `/etc/`.
  - Ensured executable permissions for `/var/www/cgi-bin/webcamstream` and `/etc/run`.

- **New Files:**
  - Introduced `camera/huser` for user authentication credentials. 

- **Breaking Change:**
  - Authentication now required for `/admin`; ensure user `shaman007` is configured.

## 2024-01-03 – `8a8dbf0` by Andrey Bondarenko
- **Configuration Update**  
  - Consolidated server module declarations in `camera/10-cgi.conf`: combined `mod_cgi`, `mod_auth`, and `mod_authn_file` into a single line.  
- **File Path**  
  - Updated configuration file: `camera/10-cgi.conf`.  
- **Breaking Change**  
  - Ensure compatibility with the new module declaration format; verify server behavior post-update.

## 2024-01-03 – `04e5a87` by Andrey Bondarenko
- **Configuration Changes**
  - Reordered `server.modules` in `camera/10-cgi.conf`: moved `"mod_cgi"` to the end of the list.
  
- **Authentication Settings**
  - No changes to authentication settings; `auth.backend` remains set to `"htdigest"` with userfile at `"/etc/huser"`.

## 2024-01-03 – `fd94f48` by Andrey Bondarenko
- **Configuration Changes**  
  - Commented out authentication requirement for `/admin` in `camera/10-cgi.conf`.  
  - Updated `auth.require` block to disable basic authentication for user `shaman007`.

## 2024-01-03 – `caa1089` by Andrey Bondarenko
- **Configuration Update**  
  - Modified `camera/10-cgi.conf` to change authentication requirements for `/cgi-bin` endpoint.
  - Added basic authentication for `/cgi-bin` with user `shaman007`.
  - Removed commented-out legacy authentication block for `/admin`.

## 2024-01-03 – `56483de` by Andrey Bondarenko
- **Docker Configuration**
  - Added `Dockerfile` for building vsftpd container with Debian slim base.
  - Configured environment variables for FTP user and password management.

- **Script Enhancements**
  - Introduced `run-vsftpd.sh` for dynamic configuration of vsftpd settings at runtime.
  - Generates random FTP passwords if not specified and sets up user directories.

- **Configuration Files**
  - Created `vsftpd.conf` with essential FTP settings, including virtual user support and logging.
  - Added `vsftpd_virtual` PAM configuration for virtual user authentication.

- **File Permissions and Structure**
  - Set ownership and permissions for `/home/vsftpd` and log directories.
  - Exposed necessary ports (20, 21) for FTP operations.

- **Breaking Changes**
  - New containerized setup; existing deployments may require migration to the new Docker-based architecture.

## 2024-01-09 – `82fb0d3` by Andrey Bondarenko
- **Removed Files**:
  - Deleted `vsftpd/Dockerfile`, `vsftpd/run-vsftpd.sh`, `vsftpd/vsftpd.conf`, and `vsftpd/vsftpd_virtual`.
  
- **Configuration Changes**:
  - All configuration and setup scripts for the vsftpd service have been removed, impacting deployment and runtime behavior.

- **Breaking Changes**:
  - The removal of the Dockerfile and associated scripts means existing setups will require significant reconfiguration or alternative solutions for FTP service deployment.

## 2024-01-11 – `784674a` by Andrey Bondarenko
- **Documentation Update**
  - Added note about VSFTPD Docker image for ARM support in `README.md`.

## 2024-01-17 – `361b78a` by Andrey Bondarenko
- **Docker Configuration**  
  - Added `Dockerfile` for Plex Media Server setup based on `debian:stable-slim`.
  - Configured APT repository for Plex and installed `plexmediaserver`.
  - Implemented cleanup commands to reduce image size.

- **Run Script**  
  - Introduced `run` script to serve as the container's entry point, maintaining a persistent loop.

## 2024-01-17 – `409f977` by Andrey Bondarenko
- **Dockerfile Updates**
  - Added installation of `ca-certificates`, `curl`, and `gnupg` for secure key handling.
  - Updated Plex repository key handling: 
    - Downloaded and converted the Plex GPG key to a keyring format.
    - Changed repository source list to use the new keyring path.
- **Build Process**
  - Enhanced security for the Plex Media Server installation process.

## 2024-02-22 – `14329d6` by Andrey Bondarenko
- **Webcam Stream Configuration**
  - Updated RTSP stream URL from `192.168.1.20` to `192.168.1.115` in `camera/webcamstream`.
  
- **File Changes**
  - Modified `camera/webcamstream` script for webcam streaming.

## 2024-02-22 – `6a2f9bc` by root
- **PHP Dockerfile Updates:**
  - Changed PHP installation from version-specific (`php8.2-*`) to generic (`php-*`) packages in `php/Dockerfile`.
  - Updated package installation commands to streamline dependencies.

- **Plex Dockerfile Enhancements:**
  - Added user and group entries for `plex` and `video` in `plex/Dockerfile`.
  - Ensured proper permissions by modifying `run` script to executable (`100755`).

- **General Maintenance:**
  - Cleaned up APT cache and removed unnecessary packages in both Dockerfiles.

## 2024-04-10 – `9816aa2` by Andrey Bondarenko
- **Dockerfile Update**
  - Upgrade LanguageTool from version 6.3 to 6.4.
  - Adjusted `mv` command in `languagetool/Dockerfile` to reflect new version.

## 2024-04-10 – `e7045c0` by Andrey Bondarenko
- **Postfix Script Update**
  - Replaced `tail -f /var/log/mail.log` with `while true; do sleep 1; done;` in `postfix/run`.
  - Ensures the script runs indefinitely without logging output.

## 2024-04-10 – `d600692` by Andrey Bondarenko
- **Dockerfile Updates**
  - Added symbolic link for mail log: `RUN ln -sf /dev/stdout /var/log/mail.log` to redirect logs.
- **Package Management**
  - Updated package installation and cleanup commands for efficiency.

## 2024-04-10 – `663f777` by Andrey Bondarenko
- **Dockerfile Updates**
  - Changed logging redirection: updated `RUN ln -sf /dev/stdout /var/log/mail.log` to `RUN ln -sf /proc/1/fd/1 /var/log/mail.log` for improved log handling.
  
- **Cleanup**
  - Maintained apt package management with removal of unnecessary packages and cleanup commands.

## 2024-04-10 – `880e10a` by Andrey Bondarenko
- **Dockerfile Updates**
  - Added `RUN newaliases` to ensure aliases are generated during image build.
  
- **Run Script Modifications**
  - Removed `newaliases` command from the `run` script to avoid redundancy.
  
- **File Paths**
  - Updated `postfix/Dockerfile` and `postfix/run`.

## 2024-04-10 – `b653325` by Andrey Bondarenko
- **Dockerfile Updates:**
  - Added symbolic link for logging: `ln -sf /proc/1/fd/1 /var/log/mail.log`.

- **Run Script Modifications:**
  - Replaced `tail -F /var/log/mail.log` with an infinite sleep loop: `while true; do sleep 1; done;`.

**Note:** The change in the run script may affect log monitoring behavior.

## 2024-04-10 – `88bb9cb` by Andrey Bondarenko
- **Dockerfile Updates**
  - Added symbolic link for PHP-FPM logging: `RUN ln -sf /proc/1/fd/1 /var/log/php8.2-fpm.log` to redirect logs.
- **File Path**
  - Modified `php/Dockerfile`.

## 2024-05-02 – `d009258` by Andrey Bondarenko
- **Documentation Updates**
  - Corrected spelling in README.md: "particulair" to "particulairly".
  - Added period at the end of the VSFTPD description in README.md.

- **File Removal**
  - Removed `compose-dev.yaml`, which contained service definitions for the development environment.

## 2024-07-31 – `394c84b` by Andrey Bondarenko
- **Configuration Changes**
  - Removed `php/opcache.ini`.
  - Added new `php/php.ini` with comprehensive PHP settings.
  - Updated `php/www.conf` to set `pm.max_children` to 120 (down from 240).

- **Performance Tuning**
  - Adjusted OPcache settings in `php/php.ini`:
    - Increased `opcache.memory_consumption` to 256MB.
    - Set `opcache.max_accelerated_files` to 4000.
    - Changed `opcache.revalidate_freq` to 60 seconds.

- **Breaking Changes**
  - Removal of `opcache.ini` may affect existing configurations relying on it. Ensure to migrate settings to `php.ini`.

## 2024-07-31 – `18a61a2` by Andrey Bondarenko
- **Dockerfile Updates**
  - Added creation of directory `/etc/php/8.2/fpm/pool.d/`.
  - Copied `php.ini` to `/etc/php/8.2/fpm/pool.d/`.
  
- **File Management**
  - Ensured `www.conf` is placed in the new pool directory. 

- **General Maintenance**
  - Updated package installation and cleanup commands.

## 2024-07-31 – `a23b8ba` by Andrey Bondarenko
- **Dockerfile Updates**
  - Added creation of directory `/etc/php/8.2/fpm/mods-available`.
  
- **File Operations**
  - No files were removed; new directory structure established for PHP configuration.

## 2024-07-31 – `9091ef0` by Andrey Bondarenko
- **Dockerfile Updates**
  - Changed directory for PHP mods from `/etc/php/8.2/fpm/mods-available` to `/etc/php/8.2/mods-available`.
  - Adjusted `RUN` command to reflect new path for mods-available. 

- **File Operations**
  - Copied `opcache.ini` and `apcu.ini` to the updated `/etc/php/8.2/mods-available` directory. 

**Note:** Ensure any references to the old mods path are updated in related configurations.

## 2024-07-31 – `7d08724` by Andrey Bondarenko
- **Dockerfile Updates**
  - Removed `COPY opcache.ini /etc/php/8.2/mods-available` from `php/Dockerfile`.
  - Ensured `apcu.ini` is copied to `/etc/php/8.2/mods-available`.

## 2024-07-31 – `ef35059` by Andrey Bondarenko
- **Configuration Changes:**
  - Removed Redis session handler configuration from `php/php.ini`.
    - `session.save_handler` set to `redis` was deleted.
    - `session.save_path` pointing to Redis server was deleted. 

**Note:** Ensure to configure session handling appropriately after this change.

## 2024-07-31 – `55d748a` by Andrey Bondarenko
- **Dockerfile Updates:**
  - Added `php-fpm.conf` to `/etc/php/8.2/fpm/pool.d/`.
  
- **New Configuration File:**
  - Introduced `php/php-fpm.conf` with global and pool settings for PHP-FPM, including error logging and process management parameters.

## 2024-07-31 – `2717f59` by Andrey Bondarenko
- **Dockerfile Updates**
  - Moved `php-fpm.conf` from `/etc/php/8.2/fpm/pool.d/` to `/etc/php/8.2/fpm/`.
  - Ensured directory structure for PHP 8.2 FPM configuration is maintained.

## 2024-07-31 – `0d53026` by Andrey Bondarenko
- **Script Update**: 
  - Added infinite loop (`while true; do sleep 1; done;`) before `php-fpm8.2` command in `php/run` script.
  
- **File Modified**: 
  - `php/run` - now includes a sleep mechanism to prevent immediate exit after starting PHP-FPM.

## 2024-07-31 – `f7b3ce9` by Andrey Bondarenko
- **Script Update**  
  - Removed infinite loop (`while true; do sleep 1; done;`) from `php/run`.
  - Adjusted script to directly run `php-fpm8.2 -R -F` without preceding sleep.

## 2024-08-01 – `de00c6c` by Andrey Bondarenko
- **Dockerfile Updates**
  - Removed `COPY www.conf` and `COPY php-fpm.conf` from Dockerfile.
  - Added `COPY php.ini` to `/etc/php/8.2/fpm/pool.d/`.

- **Configuration Changes**
  - Removed trailing newline in `php.ini`.

- **Run Script Modification**
  - Updated `run` script to specify configuration file with `-c /etc/php/8.2/fpm/php.ini`.

**Note:** Ensure the absence of `www.conf` and `php-fpm.conf` does not affect application functionality.

## 2024-08-04 – `526265c` by Andrey Bondarenko
- **Configuration Updates**:
  - Enabled `listen.owner` and `listen.group` settings in `php/www.conf`.
  - Set `env[PATH]` to inherit the system PATH variable.
  
- **File Affected**:
  - `php/www.conf` - Configuration file for PHP settings.

## 2024-10-17 – `00774b0` by Andrey Bondarenko
- **Dockerfile Update**
  - Upgraded LanguageTool from version 6.4 to 6.5 in `languagetool/Dockerfile`.
  - Adjusted directory move command to reflect new version.

## 2024-10-25 – `1e3da09` by Andrey Bondarenko
- **Dockerfile Updates**
  - Added `vim-tiny` to the installation list in `dovecot/Dockerfile`.

## 2024-10-25 – `0977ec1` by Andrey Bondarenko
- **Build Script Update**
  - Added custom `PATH` variable to `build.sh`.
  - Included `git pull` command to ensure latest code is fetched before execution.
- **File Changes**
  - Modified `build.sh` to enhance environment setup and ensure up-to-date code.

## 2024-11-15 – `16fd009` by Andrey Bondarenko
- **New Features**
  - Added `photon/Dockerfile` for containerization.
  - Introduced `photon/entrypoint.sh` to manage Elasticsearch index download and Photon startup.

- **Functionality**
  - Script checks for Elasticsearch index directory; downloads if missing.
  - Starts Photon service if the index is present; otherwise, logs an error message.

- **Important Paths**
  - `photon/Dockerfile`: New Docker configuration file.
  - `photon/entrypoint.sh`: New entrypoint script for managing service initialization.

## 2024-11-15 – `434b5e1` by Andrey Bondarenko
- **Dockerfile Updates**
  - Added Dockerfile for Photon service.
  - Base image set to `openjdk:8-jre`.
  - Installed `pbzip2` and `wget` for parallel extraction.
  - Set working directory to `/photon`.
  - Added Photon JAR from GitHub release (version 0.6.0).
  - Included `entrypoint.sh` script.
  - Exposed port `2322` and defined entrypoint. 

- **Volume Configuration**
  - Configured volume at `/photon/photon_data`.

## 2024-11-15 – `866e042` by Andrey Bondarenko
- **Dockerfile Update**
  - Changed base image from `openjdk:8-jre` to `openjdk:latest` in `photon/Dockerfile`.
  
**Note:** This change may introduce breaking changes due to potential incompatibilities with the latest OpenJDK version.

## 2024-11-15 – `13ff60e` by Andrey Bondarenko
- **Dockerfile Updates**
  - Updated base image to `openjdk:latest`.
  - Enhanced package installation command:
    - Combined `apt-get update` and `apt-get upgrade`.
    - Added `curl` and `vim` to installation.
    - Included `apt-get autoremove` and `apt-get clean` for better image size management.
    - Cleared temporary files in `/tmp` and `/var/tmp`.

- **File Path**
  - Modified: `photon/Dockerfile`

## 2024-11-15 – `83c0ac8` by Andrey Bondarenko
- **Dockerfile Update**
  - Changed base image from `openjdk:latest` to `openjdk:9-jre-slim`.
- **System Dependencies**
  - Updated package installation commands to ensure compatibility with the new base image.

## 2024-11-15 – `e2ea6ed` by Andrey Bondarenko
- **Dockerfile Update**
  - Changed base image from `openjdk:9-jre-slim` to `openjdk:24-slim-bullseye`.
- **System Dependencies**
  - Updated package installation commands to ensure compatibility with the new base image.

## 2024-11-15 – `930f8e0` by Andrey Bondarenko
- **Dockerfile Update**
  - Changed base image in `photon/Dockerfile` to `openjdk:24-slim-bullseye`.
  - Ensured compatibility with updated package management commands.

## 2024-11-15 – `540f439` by Andrey Bondarenko
- **Dockerfile Update**
  - Changed `ENTRYPOINT` syntax from string to array format in `photon/Dockerfile` for better handling of arguments.
  - Ensured proper execution of the entrypoint script.

## 2024-11-15 – `823740c` by Andrey Bondarenko
- **Enhancements**
  - Added an infinite loop at the end of `photon/entrypoint.sh` to keep the script running.

- **File Modified**
  - `photon/entrypoint.sh`

## 2024-11-15 – `ce707b7` by Andrey Bondarenko
- **Dockerfile Updates**
  - Replaced `pbzip2` with `bzip2` in package installation.
  - Added executable permission to `entrypoint.sh` with `RUN chown +x /entrypoint.sh`.
  - Cleaned up package lists and temporary files post-installation.

## 2024-11-15 – `9368346` by Andrey Bondarenko
- **Dockerfile Updates**
  - Changed permission command from `chown +x` to `chmod +x` for `entrypoint.sh`.
  - Ensured executable permissions are correctly set for the entrypoint script.

## 2024-11-15 – `e41893f` by Andrey Bondarenko
- **Dockerfile Updates**
  - Changed `RUN chmod +x /entrypoint.sh` to `RUN chmod +x ./entrypoint.sh` for relative path consistency.
- **File Path**
  - Affected file: `photon/Dockerfile`

## 2025-04-10 – `30d1d80` by Andrey Bondarenko
- **Build Process Update**
  - Updated `build.sh` to use `docker buildx` for multi-platform builds targeting `linux/amd64` and `linux/arm64`.
  - Maintained existing functionality for building and pushing Docker images.

## 2025-04-10 – `51b7613` by Andrey Bondarenko
- **Build Process Changes**
  - Removed Docker push command from `build.sh` to streamline the build process.

- **New Script Addition**
  - Added `list.sh` for listing Docker repositories and their tags from the specified registry.
  - Implements multi-architecture manifest fetching and parsing.

- **File Modifications**
  - `build.sh`: Adjusted build steps; no longer pushes images post-build.
  - `list.sh`: New file with extensive functionality for interacting with Docker registry.

- **Important Notes**
  - Ensure to replace placeholder credentials in `list.sh` for authentication.

## 2025-04-10 – `ac5c152` by Andrey Bondarenko
- **Build Process**
  - Updated `build.sh` to push Docker images directly during the build process with `--push` flag.

- **LanguageTool Update**
  - Upgraded LanguageTool version from 6.5 to 6.6 in `languagetool/Dockerfile`. 

No breaking changes noted.

## 2025-04-12 – `8dcc43b` by Andrey Bondarenko
- **Dockerfile Updates**:
  - Changed `ADD` to `COPY` for `run` in both `dovecot/Dockerfile` and `rspamd/Dockerfile`.
  
- **Service Configuration**:
  - Ensured consistent service directory creation with `mkdir /etc/service` in both Dockerfiles. 

- **Logging**:
  - Updated logging redirection to stdout in both services. 

No breaking changes noted.

## 2025-04-12 – `e0d22e7` by Andrey Bondarenko
- **Dockerfile Updates:**
  - Added `dumb-init` to handle PID 1.
  - Changed `ENTRYPOINT` to use `dumb-init` for better signal handling.

- **Run Script Modifications:**
  - Replaced `dovecot` command with `exec /usr/sbin/dovecot -F` for proper foreground execution.
  - Removed infinite sleep loop for streamlined process management.

- **File Changes:**
  - Updated `dovecot/Dockerfile` and `dovecot/run`. 

- **Breaking Change:**
  - The run script now directly executes Dovecot in the foreground, altering the service startup behavior.

## 2025-04-12 – `8f814c9` by Andrey Bondarenko
- **Dockerfile Updates:**
  - Added `dumb-init` to `camera`, `clamav`, `languagetool`, and `minecraft-cli` Dockerfiles for better process management.
  - Changed ENTRYPOINT to use `dumb-init` in all updated Dockerfiles.

- **Service Scripts:**
  - Removed unnecessary infinite sleep loops in `camera/run`, `minecraft-cli/run`, and `minio-single/run` scripts.

- **File Modifications:**
  - Updated `run` scripts to improve service handling and reduce idle time.

- **Important Files:**
  - `camera/Dockerfile`, `clamav/Dockerfile`, `languagetool/Dockerfile`, `minecraft-cli/Dockerfile`, `minio-single/run` are significantly modified.

- **Breaking Changes:**
  - ENTRYPOINT modification may affect service startup behavior; ensure compatibility with existing configurations.

## 2025-04-12 – `aadd129` by Andrey Bondarenko
- **Dockerfile Enhancements**
  - Added architecture detection for installing MinIO and MinIO client based on system architecture (amd64, arm64).
  - Included `dumb-init` for better signal handling in the container.
  - Updated `ENTRYPOINT` to use `dumb-init` for improved process management.
  - Cleaned up unnecessary files after installations to reduce image size. 

- **File Changes**
  - Modified `minio-single/Dockerfile` to implement the above improvements.

## 2025-04-12 – `924d7ec` by Andrey Bondarenko
- **Script Enhancements**:
  - Updated `run` scripts for `minecraft-cli`, `mysql-cli`, `postgres-cli`, and `redis-cli` to use `set -euo pipefail` for improved error handling.
  - Added startup message: "Container started. Sleeping forever..." to each script.
  - Replaced infinite loop with `exec tail -f /dev/null` to keep the container running. 

- **Files Modified**:
  - `minecraft-cli/run`
  - `mysql-cli/run`
  - `postgres-cli/run`
  - `redis-cli/run` 

No breaking changes noted.

## 2025-04-12 – `1038eac` by Andrey Bondarenko
- **Dockerfile Updates**:
  - Changed base image from `debian:stable-slim` to `docker.io/library/debian:stable-slim` across all Dockerfiles in the following directories:
    - `camera`
    - `clamav`
    - `dovecot`
    - `languagetool`
    - `minecraft-cli`
    - `minio-single`
    - `mysql-cli`
    - `php`
    - `plex`
    - `postfix`
    - `postgres-cli`
    - `redis-cli`
    - `rspamd`
    - `rsyslog`
  
- **General Improvements**:
  - Updated package installation commands to ensure consistent usage of `apt-get` and `apt` across Dockerfiles.
  - Cleaned up package lists and temporary files post-installation for all services.

## 2025-04-12 – `95cbac0` by Andrey Bondarenko
- **Dockerfile Updates**
  - Removed redundant line break in `minio-single/Dockerfile`.
  - Maintained installation of dependencies: `wget` and `dumb-init`.

## 2025-04-12 – `b1c117b` by Andrey Bondarenko
- **Dockerfile Updates:**
  - Added `dumb-init` to multiple Dockerfiles for better signal handling:
    - `mysql-cli/Dockerfile`
    - `photon/Dockerfile`
    - `php/Dockerfile`
    - `postfix/Dockerfile`
    - `postgres-cli/Dockerfile`
    - `redis-cli/Dockerfile`
    - `rspamd/Dockerfile`
  - Updated ENTRYPOINT in all affected Dockerfiles to use `dumb-init`.

- **Script Enhancements:**
  - Modified `php/run` and `plex/run` scripts to use `set -euo pipefail` for improved error handling.
  - Added logging message in `plex/run` to indicate container start.

- **General Maintenance:**
  - Cleaned up package installations and removed unnecessary packages across Dockerfiles.

## 2025-04-12 – `7991bc3` by Andrey Bondarenko
- **Script Enhancements**:
  - Updated all service run scripts (`camera/run`, `clamav/run`, `dovecot/run`, `minio-single/run`, `postfix/run`, `rspamd/run`) to use `set -euo pipefail` for improved error handling.

- **Affected Files**:
  - `camera/run`
  - `clamav/run`
  - `dovecot/run`
  - `minio-single/run`
  - `postfix/run`
  - `rspamd/run`

- **Breaking Change**:
  - Scripts now terminate on unset variables, which may affect existing configurations relying on unset variables being ignored.

## 2025-04-12 – `b7c6112` by Andrey Bondarenko
- **Postfix Run Script Update**
  - Replaced `postfix start` with `exec postfix start-fg` for foreground execution.
  - Removed infinite sleep loop to streamline process management in `postfix/run`.

## 2025-04-12 – `8aa4a93` by Andrey Bondarenko
### CHANGELOG for Commit 8aa4a93

- **Dockerfile Updates**:
  - Replaced `apt update` with `apt-get update` in multiple Dockerfiles for consistency.
  - Fixed typos in package installation commands (e.g., `apt-get-y` corrected to `apt-get -y`).
  - Updated installation commands across various services including `clamav`, `languagetool`, `minecraft-cli`, `minio-single`, `mysql-cli`, `photon`, `php`, `plex`, `postfix`, `postgres-cli`, `redis-cli`, and `rsyslog`.

- **File Modifications**:
  - Adjusted `COPY` commands and entry points in `minecraft-cli`, `mysql-cli`, `postgres-cli`, and `redis-cli` Dockerfiles.
  - Minor changes to the `LICENSE` file in `postfix` to clarify modification terms.

- **Important Notes**:
  - Ensure all Dockerfiles are rebuilt to reflect the changes in package management commands.
  - No breaking changes identified, but review for potential impacts from command corrections.

## 2025-04-12 – `01c60c7` by Andrey Bondarenko
- **Dockerfiles Update**
  - Updated `camera/Dockerfile`, `languagetool/Dockerfile`, and `php/Dockerfile` for improved build efficiency.
  
- **General Improvements**
  - Optimized layer caching and reduced image sizes across all Dockerfiles.

## 2025-04-12 – `e9db634` by Andrey Bondarenko
- **Dockerfile Updates**:
  - Updated `minio-single/Dockerfile` for improved build efficiency.
  - Enhanced `mysql-cli/Dockerfile` with new dependencies.
  - Refined `plex/Dockerfile` for better performance.
  - Optimized `postfix/Dockerfile` configuration.
  - Updated `postgres-cli/Dockerfile` for compatibility with latest PostgreSQL.
  - Improved `redis-cli/Dockerfile` for streamlined image size.
  - Enhanced `rsyslog/Dockerfile` for better logging capabilities. 

- **General**:
  - No breaking changes noted.

## 2025-04-12 – `84c8ce9` by Andrey Bondarenko
- **Docker Build Update**
  - Changed image tag prefix from `$registry/$app:$label` to `$registry/library/$app:$label` in `build.sh`.
- **File Modified**
  - Updated `build.sh` to reflect new tagging convention for Docker images.

## 2025-04-12 – `c4de78b` by Andrey Bondarenko
- **Build Script Update**  
  - Changed Docker registry URL in `build.sh` from `registry.andreybondarenko.com` to `harbor.andreybondarenko.com`.

## 2025-04-14 – `c1d351b` by Andrey Bondarenko
- **Build Script Enhancements**  
  - Added `set -euo pipefail` for improved error handling in `build.sh`.
  - Introduced timestamp variable for tagging Docker images with build time.
  
- **Docker Build Process**  
  - Updated Docker image tagging to include both `latest` and timestamp tags.
  - Modified app directory traversal to ensure correct handling of directories.

- **File Affected**  
  - `build.sh` - significant changes to build logic and error handling.

## 2025-04-14 – `482e745` by Andrey Bondarenko
- **Build Script Update**
  - Refactored `apps` array initialization in `build.sh` to collect non-hidden directories.
  - Replaced `ls` and `grep` approach with a `for` loop for improved clarity and performance.

## 2025-05-15 – `4abee6b` by Andrey Bondarenko
- **New Features**
  - Added `Dockerfile` for building the connectivity exporter image.
  - Introduced `config.yaml` with multiple endpoint checks for connectivity validation.
  - Created `run` script to execute the connectivity exporter with specified configuration.

- **File Additions**
  - `connectivity-exporter/Dockerfile`: Defines the Docker image setup.
  - `connectivity-exporter/config.yaml`: Configuration for connectivity checks.
  - `connectivity-exporter/run`: Bash script to run the exporter.

- **Dependencies**
  - Installs `prometheus_client` and `pyyaml` in the Docker image.

- **Execution**
  - Uses `dumb-init` for process management in the Docker container.

## 2025-05-15 – `3dd5226` by Andrey Bondarenko
- **Dockerfile Updates**
  - Added executable permission to `/etc/run` script.
  - Updated base image to `python:3.11-slim`.
  - Installed `prometheus_client` and `pyyaml` without cache.

## 2025-05-15 – `1da8454` by Andrey Bondarenko
- **Dockerfile Updates**
  - Added `dumb-init` installation to handle process reaping and signal forwarding.
  - Included commands for `apt-get update`, `upgrade`, `autoremove`, and `clean` to optimize image size and security.
  - Cleaned up temporary files post-installation to reduce image footprint.

## 2025-05-15 – `6e9b79d` by Andrey Bondarenko
- **Dockerfile Updates**
  - Added `bash` installation to `connectivity-exporter/Dockerfile`.
  - Maintained existing package management commands for cleanup and optimization.

## 2025-05-15 – `2a7c51a` by Andrey Bondarenko
- **Script Update**: Removed shebang (`#!/usr/bin/env bash`) from `connectivity-exporter/run`.
- **Execution Command**: Retained `set -euo pipefail` and execution of Python script with config.

## 2025-05-15 – `02bfc7e` by Andrey Bondarenko
- **Script Update**
  - Commented out `set -euo pipefail` in `connectivity-exporter/run`.
  
- **Execution Command**
  - Maintained execution of `connectivity-exporter.py` with specified config.

## 2025-05-15 – `396cdd7` by Andrey Bondarenko
- **Script Update**: Removed error handling (`set -euo pipefail`) from `connectivity-exporter/run`.
- **Execution Command**: Maintained execution of `connectivity-exporter.py` with the specified configuration file.

## 2025-06-02 – `fca0299` by fossabot
- **Documentation Updates**
  - Added FOSSA status badges to `README.md` for project license tracking.
  - Introduced a new "License" section in `README.md`.

## 2025-06-07 – `6cc29ac` by Andrey Bondarenko
- **Dockerfile Updates**
  - Added `libimage-exiftool-perl` to PHP Docker image dependencies.
  - Removed `git` during installation to streamline the image.

## 2025-06-07 – `be8f3bb` by Andrey Bondarenko
- **Dockerfile Updates**
  - Removed installation of `bash` from `connectivity-exporter/Dockerfile`.
  - Maintained other package management commands for cleanliness and efficiency.

## 2025-06-10 – `a44b233` by Andrey Bondarenko
- **Dockerfile Updates**
  - Added `flask` to the Python package installation in `connectivity-exporter/Dockerfile`.
  - Updated package management commands for better cleanup after installation.

## 2025-07-08 – `bd2558b` by Andrey Bondarenko
- **CI/CD Workflow**: 
  - Added new GitHub Actions workflow for Docker image publishing in `.github/workflows/docker-publish.yml`.
  - Configured to trigger on scheduled events, pushes to `main`, and pull requests.

- **Docker Build Process**:
  - Integrated Docker Buildx for building and pushing images.
  - Implemented signing of images using Cosign for security.

- **Environment Variables**:
  - Set `REGISTRY` to `ghcr.io` and `IMAGE_NAME` to the GitHub repository name.

- **Permissions**:
  - Specified permissions for reading contents and writing packages and ID tokens.

- **Important Notes**:
  - Ensure Dockerfiles are located in subdirectories for the build process to function correctly.

## 2025-07-08 – `8e5a8bc` by Andrey Bondarenko
- **Workflow Update**
  - Modified Docker image naming convention in `.github/workflows/docker-publish.yml`.
  - Changed image name from `${IMAGE_NAME}-${name}` to `${name}` for clarity.

## 2025-07-08 – `3527b61` by Andrey Bondarenko
- **Docker Image Naming**: Updated image naming convention in `.github/workflows/docker-publish.yml` to include `shaman007` prefix.
- **File Modified**: Changes made exclusively in `.github/workflows/docker-publish.yml`.

## 2025-07-08 – `316eb56` by Andrey Bondarenko
- **Docker Publish Workflow Update**
  - Replaced `docker buildx imagetools inspect` with `cosign triangulate` for digest retrieval in `.github/workflows/docker-publish.yml`.
  - Updated signing process to utilize `cosign` for image verification.

## 2025-07-08 – `e15c26d` by Andrey Bondarenko
- **Workflow Update**
  - Modified Docker publish workflow in `.github/workflows/docker-publish.yml`.
  - Changed command to extract digest from `cosign triangulate` output using `cut -d@ -f2`.

## 2025-07-08 – `61b938f` by Andrey Bondarenko
- **Workflow Update**: Fixed syntax error in `.github/workflows/docker-publish.yml`.
  - Corrected missing closing parenthesis in the `digest` assignment line.

## 2025-07-08 – `8d83e6e` by Andrey Bondarenko
- **GitHub Actions**: 
  - Updated Docker publish workflow in `.github/workflows/docker-publish.yml`.
  - Changed image signing process to use `ref` instead of `digest` for improved clarity.

## 2025-07-08 – `0cc486d` by Andrey Bondarenko
- **GitHub Actions Workflow Update**
  - Modified `.github/workflows/docker-publish.yml` for improved Docker image building.
  - Added `--build-arg BUILDKIT_INLINE_CACHE=1` to enhance caching.
  - Changed output handling to capture image digest for signing.
  - Removed conditional push logic; now always signs the image reference.

## 2025-07-08 – `879f693` by Andrey Bondarenko
- **GitHub Actions Workflow Update**
  - Modified `docker-publish.yml` to remove `head -n1` from digest extraction, allowing for multiple digests to be captured.
  - Adjusted digest assignment to improve flexibility in handling output from Docker build.

## 2025-07-08 – `69a6a32` by Andrey Bondarenko
- **GitHub Actions**: 
  - Added output logging for Docker image build in `.github/workflows/docker-publish.yml`.
  - Echoes the build output before extracting the digest.

## 2025-07-08 – `c9d4fb7` by Andrey Bondarenko
- **Enhancements to Docker Publish Workflow**
  - Added visual separators in output logs for clarity in `.github/workflows/docker-publish.yml`.
  - Improved output echoing for better readability during Docker image publishing.

## 2025-07-08 – `f51e3bc` by Andrey Bondarenko
- **GitHub Actions Workflow Update**
  - Updated `.github/workflows/docker-publish.yml` to use `skopeo` for digest retrieval instead of parsing output.
  - Removed unnecessary echo statements for output clarity.
  - Adjusted reference format for image digest to streamline signing process. 

- **Breaking Change**
  - The digest retrieval method has changed; ensure compatibility with `skopeo` and `cosign` in CI/CD pipeline.

## 2025-07-08 – `239f3d5` by Andrey Bondarenko
- **Dockerfile Updates:**
  - Replaced `connectivity-exporter.py` with `check.py` in `/app` directory.
  - Adjusted `COPY` command to place `config.yaml` in `/app`.

- **Run Script Modification:**
  - Updated execution command in `run` script to use `check.py` instead of `connectivity-exporter.py`.

- **File Path Changes:**
  - `check.py` now sourced from GitHub instead of local repository. 

- **Breaking Change:**
  - The main executable script has changed from `connectivity-exporter.py` to `check.py`, requiring updates to any dependent configurations or scripts.

## 2025-07-08 – `70fcdca` by Andrey Bondarenko
- **Docker Configuration**
  - Added new `Dockerfile` for `connectivity-exporter-local`.
  - Removed existing `Dockerfile` for `connectivity-exporter`.

- **Configuration Files**
  - Introduced new `config.yaml` for `connectivity-exporter-local`.
  - Deleted old `config.yaml` from `connectivity-exporter`.

- **Run Scripts**
  - Added new `run` script for `connectivity-exporter-local`.
  - Removed old `run` script from `connectivity-exporter`.

- **Breaking Changes**
  - Migration from `connectivity-exporter` to `connectivity-exporter-local` with complete configuration and script overhaul.

## 2025-07-08 – `2243864` by Andrey Bondarenko
- **GitHub Actions Workflow Updates**
  - Added QEMU setup step in `.github/workflows/docker-publish.yml` for multi-platform builds.
  - Configured Docker Buildx to support `linux/amd64` and `linux/arm64` platforms during image build.

## 2025-07-08 – `38c0fc9` by Andrey Bondarenko
- **Workflow Update**: 
  - Removed commented-out lines for digest extraction and reference formatting in `.github/workflows/docker-publish.yml`.
  - Cleaned up Docker image signing process by simplifying the reference generation.
