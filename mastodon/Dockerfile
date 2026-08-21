FROM harbor.andreybondarenko.com/github/mastodon/mastodon:v4.7.0
# mastodon-image-tag: v4.6.6-1

USER root

RUN sed -i \
      "s/MAX_CHARS = 500/MAX_CHARS = Integer(ENV.fetch('MAX_TOOT_CHARS', '500'), 10)/" \
      /opt/mastodon/app/validators/status_length_validator.rb \
    && grep -Fq "MAX_CHARS = Integer(ENV.fetch('MAX_TOOT_CHARS', '500'), 10)" \
      /opt/mastodon/app/validators/status_length_validator.rb

# Followed hashtags are delivered to the home timeline through the `tags`
# feed path. Apply the exclusive-list check there too, while preserving the
# intentionally narrower filtering semantics for followed hashtags.
RUN sed -i \
      's/filter_from_tags?(status, receiver.id, build_crutches(receiver.id, \[status\])) ? :filter : nil/(crutches = build_crutches(receiver.id, [status]); crutches[:exclusive_list_users][status.account_id].present? || filter_from_tags?(status, receiver.id, crutches)) ? :filter : nil/' \
      /opt/mastodon/app/lib/feed_manager.rb \
    && grep -Fq '(crutches = build_crutches(receiver.id, [status]); crutches[:exclusive_list_users][status.account_id].present? || filter_from_tags?(status, receiver.id, crutches)) ? :filter : nil' \
      /opt/mastodon/app/lib/feed_manager.rb \
    && ruby -c /opt/mastodon/app/lib/feed_manager.rb

USER 991
