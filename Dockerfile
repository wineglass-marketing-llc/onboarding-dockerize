#bundler install --without production
#new tab
#rake jobs:work
#cat config/application.yml
#added application.yml
# custom ruby image that has working version of 2.3.0
#FROM wisehackermonkey/alpine-ruby-2.3.0:1.0.0
FROM ruby:2.5.3-alpine3.9
MAINTAINER oran c <oranbusiness@gmail.com>

# create folder named app in the docker container
RUN mkdir /app
# add contents of 'onboarding project" that are stored ./app
ADD ./app/wgm-crm-onboarding /app

# set the docker containers working directory ie pwd -> '/app'
# when the docker container starts
WORKDIR /app
RUN gem install bundler
#RUN bundler install --without projection ./app
#RUN rails db:seed

# expose port 300 to dockercontainer
EXPOSE 3000

ENTRYPOINT ["/bin/sh"]
#CMD rails s; rake job:work
#CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]