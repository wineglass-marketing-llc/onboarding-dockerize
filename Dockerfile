#bundler install --without production
#new tab
#rake jobs:work
#cat config/application.yml
#added application.yml
# custom ruby image that has working version of 2.3.0
#FROM wisehackermonkey/alpine-ruby-2.3.0:1.0.0
FROM ruby:2.5.3-alpine3.9
MAINTAINER oran c <oranbusiness@gmail.com>

# install dependencies for ruby on rails
RUN apk add --no-cache --update build-base git libxslt-dev libxml2-dev postgresql-dev postgresql-client nodejs tzdata imagemagick
RUN apk add --no-cache --update sqlite sqlite-dev
# create folder named app in the docker container
RUN mkdir /app
# add contents of 'onboarding project" that are stored ./app
ADD ./app/wgm-crm-onboarding /app

# set the docker containers working directory ie pwd -> '/app'
# when the docker container starts
WORKDIR /app
RUN gem install bundler
RUN bundler install
RUN rails db:migrate
#RUN rails db:seed

# expose port 300 to dockercontain2er
EXPOSE 3000

#ENTRYPOINT ["/bin/sh"]
#CMD rails s; rake job:work
#                                                           CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
#CMD ["sh", "-c", "rails", "server", "-b", "0.0.0.0"]
#CMD /bin/sh -c rails server & rake jobs:work
#v 3
CMD ["/bin/sh", "-c", "rails server && rake jobs:work"]
#v4 https://stackoverflow.com/questions/50481031/docker-multiple-commands-in-cmd-after-each-other