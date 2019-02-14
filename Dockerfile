# Docker image to run our wgm onboarding app
# created by oran c (wisehackermonkey)
# oranbusiness@gmail.com
# 20190214

# Install notes
# 2 files are required for wgm onboarding app to run properly
# application.yml - configuration file
# put 'application.yml ' in the project folder ./wgm-crm-onboarding/config/application.yml

# if you are running an old version of wgm-crm-onboarding
## please change the last line of wgm-crm-onboarding to
#"./wgm-crm-onboarding/Gemfile"
#change the ruby version from
#ruby 2.3.0 -> 2.5.3
#becauseFROM ruby:2.5.3-alpine3.9 requires a new version of ruby to run
#docker hub (hub.docker.com) has no  2.3.0 version availbe that also uses alpine linux
#as its base image.

# This docker file barrows info from siklodi-mariusz in this gist
# https://gist.github.com/siklodi-mariusz/5fc5efcd1ce2c47ae428e601163a60e6

#Please change as fallows
#from
#--------------------------
#...<cliped rest of file>...
## Sentry exception handler
#gem 'sentry-raven'
#
#ruby '2.3.0'
#--------------------------
#to
#--------------------------
#...<cliped rest of file>...
## Sentry exception handler
#gem 'sentry-raven'
#
#ruby '2.5.3'
#--------------------------


# Install package notes:
# - build-base: allow compiling of gems from source
# - nodejs: need for assets
# - postgresql-dev postgresql-client: Communicate with postgres through the postgres gem
# - libxslt-dev libxml2-dev: Nokogiri native dependencies
# - imagemagick: for image processing
FROM ruby:2.5.3-alpine3.9
MAINTAINER oran c <oranbusiness@gmail.com>

# install dependences
RUN apk add --no-cache --update build-base git libxslt-dev libxml2-dev postgresql-dev postgresql-client nodejs tzdata imagemagick sqlite sqlite-dev
# create folder named app in the docker container
RUN mkdir /app
# add contents of 'onboarding project" that are stored ./app
ADD ./wgm-crm-onboarding /app

WORKDIR /app
RUN gem install bundler
RUN bundler install
RUN rails db:migrate
RUN rails db:seed

# expose port 3000 for the ruby on rails server
EXPOSE 3000

# run two command in the background on start of the container
# > rails server - runs the onboarding server
# > rake jobs:work - runs the background jobs specified by 'work"

#for more information about how to run mulitiple commands in on line
#look at this stack overflow comment
#v4 https://stackoverflow.com/questions/50481031/docker-multiple-commands-in-cmd-after-each-other
CMD ["/bin/sh", "-c", "rails server && rake jobs:work"]
