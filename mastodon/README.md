# Mastodon

This image derives from the pinned upstream Mastodon release and makes the
otherwise hard-coded local post length configurable through
`MAX_TOOT_CHARS`. It also prevents followed hashtags from bypassing exclusive
list exclusion and inserting those accounts' posts into the Home timeline.

The default remains the upstream value of `500`. Set `MAX_TOOT_CHARS` on all
Mastodon processes to raise it; for example, `5000` permits local posts of up
to 5,000 grapheme clusters. Mastodon publishes the configured limit through
its instance API, so the bundled web client can discover it.

Renovate updates the versioned upstream image in the Dockerfile. The build
intentionally fails if a new upstream release no longer contains the expected
assignment, forcing the customization to be reviewed before that release is
published.

The GitHub Actions image workflow publishes both `latest` and the upstream
Mastodon version, such as `ghcr.io/shaman007/mastodon:v4.6.5`. The Kubernetes
deployment consumes the versioned tag through the Harbor GHCR proxy, allowing
Renovate to propose the deployment update only after that image exists.
