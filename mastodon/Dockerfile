FROM ghcr.io/mastodon/mastodon:v4.6.6

USER root

RUN sed -i \
      "s/MAX_CHARS = 500/MAX_CHARS = Integer(ENV.fetch('MAX_TOOT_CHARS', '500'), 10)/" \
      /opt/mastodon/app/validators/status_length_validator.rb \
    && grep -Fq "MAX_CHARS = Integer(ENV.fetch('MAX_TOOT_CHARS', '500'), 10)" \
      /opt/mastodon/app/validators/status_length_validator.rb

USER 991
