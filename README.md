# onboarding-dockerize
##### Docker image to run our wgm onboarding app
``` 
created by oran c (wisehackermonkey)
oranbusiness@gmail.com
20190214

last updated 20190214
```
 ### Install notes
 Prerequisites
 installed 
 - git
 - docker
 
how to install
```
> git clone https://github.com/wineglass-marketing-llc/onboarding-dockerize.git
> cd onboarding-dockerize
> git clone https://github.com/WineGlassMarketing/wgm-crm-onboarding.git
# NOTE you have to be a member of the wineglassmarketing organization to use this
private repo

```
 
``` text
application.yml - configuration file
put 'application.yml ' in the project folder ./wgm-crm-onboarding/config/application.yml 

This docker file barrows info from siklodi-mariusz in this gist
https://gist.github.com/siklodi-mariusz/5fc5efcd1ce2c47ae428e601163a60e6
```
#### Please change as fallows
if you are running an OLD version of wgm-crm-onboarding

change the ruby version from
ruby 2.3.0 -> 2.5.3

because ruby:2.5.3-alpine3.9 requires a new version of ruby to run
docker hub (hub.docker.com) has no  2.3.0 version availbe that also uses alpine linux
as its base image.

please change the last line of wgm-crm-onboarding gem file  
##### From 
inside of "./wgm-crm-onboarding/Gemfile"
```
...<cliped rest of file>...
# Sentry exception handler
gem 'sentry-raven'

ruby '2.3.0'
```
##### To 
```
...<cliped rest of file>...
# Sentry exception handler
gem 'sentry-raven'

ruby '2.5.3'
```

 ##### Install package notes:
 - build-base: allow compiling of gems from source
 - nodejs: need for assets
 - postgresql-dev postgresql-client: Communicate with postgres through the postgres gem
 - libxslt-dev libxml2-dev: Nokogiri native dependencies
 - imagemagick: for image processing
 
 
 RUNNING CONTAINER
```
docker pull wisehackermonkey/onboarding
    docker run -it -d --rm -p 80:3000 --name=onboarding-container wisehackermonkey/onboarding:latest
```
 BUILDING FROM SCRATCH
```
git clone https://github.com/wineglass-marketing-llc/onboarding-dockerize.git
cd onboarding-dockerize
git clone https://github.com/WineGlassMarketing/wgm-crm-onboarding.git
OPEN ./wgm-crm-onboarding/Gemfile last line ruby '2.3.0' -> ruby '2.5.3'
docker build -t onboarding:latest .
docker run -it -d --rm -p 80:3000 --name=onboarding-container onboarding:latest
docker-machine ip

OPEN <RESULT OF MACHINE IP> in browser example http://192.168.99.100/
```