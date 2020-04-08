FROM ruby:2.6-alpine

RUN apk update && apk add build-base nodejs postgresql-dev tzdata

RUN mkdir /project
WORKDIR /project

COPY Gemfile Gemfile.lock ./
RUN gem install bundler
RUN bundle install

COPY . .
CMP ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
