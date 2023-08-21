# OpenDKIM

It it very picky for permissions of everything including directories permissions and don't want to use configmaps though they're are not regular files. So first mount all configs in the /etc/opendkinm_init, it would be montned before the container RUN entry.

