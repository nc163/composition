# syntax=docker/dockerfile:1

ARG RAILS_ENV
ARG RUBY_VERSION
ARG RUBYGEM_VERSION
ARG BUNDLER_VERSION
ARG BUNDLE_PATH
ARG BUNDLE_WITHOUT
ARG BUNDLE_FROZEN
ARG SYSTEM_USER=straysheep
ARG SYSTEM_GROUP=straysheep
ARG TZ=Asia/Tokyo


FROM ruby:$RUBY_VERSION-slim AS dependent
# Install Ruby on Rails dependencies
# https://hub.docker.com/_/ruby
ARG RUBYGEM_VERSION
ARG BUNDLER_VERSION
ARG BUNDLE_PATH
ARG BUNDLE_WITHOUT
ARG BUNDLE_FROZEN
ARG SYSTEM_USER
ARG SYSTEM_GROUP
ARG TZ

ENV TZ=$TZ

# Install Ruby on Rails dependencies
RUN apt-get update -qq \
    && DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -yqq \
        build-essential \
        pkg-config \
        git \
        tzdata \
        libvips \
    && rm -rf /var/lib/apt/lists/*

# Install RubyGems and Bundler
RUN gem update --system $RUBYGEM_VERSION --quiet \
    && gem install bundler --version $BUNDLER_VERSION --no-document --quiet

# Create system user
RUN groupadd -r $SYSTEM_GROUP \
    && useradd -r $SYSTEM_USER -g $SYSTEM_GROUP -s /bin/bash

# Workload Directory
WORKDIR /srv/be

RUN chown -R $SYSTEM_USER:$SYSTEM_GROUP . \
    && chmod -R g=u . \
    && chmod g+s .

# Workload User
USER $SYSTEM_USER

COPY --chown=$SYSTEM_USER:$SYSTEM_GROUP Gemfile Gemfile.lock  ./
COPY --chown=$SYSTEM_USER:$SYSTEM_GROUP lib ./lib

# == Install RubyGems from Gemfile
# https://bundler.io/v2.6/man/bundle-config.1.html
RUN bundle config set --local path "$BUNDLE_PATH" && \
    bundle config set --local without "$BUNDLE_WITHOUT" && \
    bundle config set --local frozen "$BUNDLE_FROZEN" && \
    bundle install --quiet && \
    rm -rf $BUNDLE_PATH/cache


# == Build Application
#
FROM dependent AS application
ARG SYSTEM_USER
ARG SYSTEM_GROUP

ENV RAILS_ENV=$RAILS_ENV \
    RUBY_YJIT_ENABLE=0 \
    SITE_DOMAIN=localhost \
    BINDING=0.0.0.0 \
    ALLOWED_HOSTS=localhost,127.0.0.1,localhost:3000,127.0.0.1:3000 \
    #
    MYSQL_HOST= MYSQL_PORT=3306 MYSQL_DATABASE= MYSQL_USERNAME= MYSQL_PASSWORD= \
    REDIS_HOST= REDIS_PORT=6379 \
    SMTP_HOST= SMTP_PORT=25 \
    FIRECRAWL_SCHEME='http' FIRECRAWL_HOST='127.0.0.1' FIRECRAWL_PORT=3002 FIRECRAWL_API_KEY='' FIRECRAWL_DEBUG='false' \
    ABRGEOCODER_SCHEME='http' ABRGEOCODER_HOST='127.0.0.1' ABRGEOCODER_PORT=3003 \
    KUBO_HOST='127.0.0.1' KUBO_PORT=3004 \
    #
    MAPBOX_ACCESS_TOKEN='' \
    GOOGLE_MAP_API_KEY='' \
    GOOGLE_GEMINI_API_KEY='' \
    GOOGLE_SEARCH_CONSOLE_API_KEY='' \
    OPENAI_ACCESS_TOKEN=''

# Entrypoint prepares the database.
COPY --chmod=755 bin/docker-entrypoint /usr/local/bin/entrypoint

COPY --chown=$SYSTEM_USER:$SYSTEM_GROUP . .

EXPOSE 3000
ENTRYPOINT ["/usr/local/bin/entrypoint"]

# CMD ["bundle", "exec", "sidekiq"]
# CMD ["bundle", "exec", "rake"]
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
