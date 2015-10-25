FROM ruby:2.2.2-slim

# dependencies
RUN \
  apt-get update && \
  apt-get -y install \
  build-essential \
  curl \
  git-core \
  libcurl4-openssl-dev \
  libc6-dev \
  libreadline-dev \
  libssl-dev \
  libxml2-dev \
  libxslt1-dev \
  libyaml-dev \
  zlib1g-dev \
  libssl-dev \
  imagemagick

RUN apt-get -y install sqlite3 libsqlite3-dev

RUN mkdir /usr/src/app
ADD . /usr/src/app/
WORKDIR /usr/src/app/

RUN bundle install
