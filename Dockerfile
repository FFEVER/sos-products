FROM ruby:2.6-alpine

ENV BUNDLER_VERSION=2.1.4

RUN apk add --update --no-cache \
      binutils-gold \
      build-base \
      curl \
      file \
      g++ \
      gcc \
      git \
      less \
      libstdc++ \
      libffi-dev \
      libc-dev \
      linux-headers \
      libxml2-dev \
      libxslt-dev \
      libgcrypt-dev \
      make \
      netcat-openbsd \
      nodejs \
      openssl \
      pkgconfig \
      postgresql-dev \
      python \
      tzdata \
      yarn

WORKDIR /app

COPY Gemfile Gemfile.lock ./

RUN gem install bundler -v 2.1.4
RUN bundle config build.nokogiri --use-system-libraries
RUN bundle check || bundle install
RUN bundle install

COPY . ./
ENTRYPOINT ["./entrypoints/docker-entrypoint.sh"]
# CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
