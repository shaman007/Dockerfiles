# Bookmarked media sync runtime

Shared runtime for the fetch and upload containers of home-k3s
`mastodon/bookmarked-media-sync`. Uses the existing Node 26 Alpine base and
Immich CLI 3.0.2. ca-certificates, coreutils, curl, jq and kubectl are installed
at image build time; no runtime apk/npm installation is needed.

Build and sign through the existing builder with `./build.sh bookmarked-media-sync`.
The normal weekly builder discovers this directory automatically. Pin the
verified published digest in home-k3s. Application scripts, dependency gates,
configuration and OpenBao-managed credentials remain supplied by Kubernetes;
the image contains none of them.
