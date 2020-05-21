FROM ruby:alpine

COPY . /usr/src/app
WORKDIR /usr/src/app

RUN apk add --no-cache --virtual build-dependencies build-base \
    && gem install bundler 

RUN gem install jekyll bundler \
    && bundle install \
    && bundle update