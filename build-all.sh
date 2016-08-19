#!/bin/bash

# This is for building and testing in development

TERM=

docker build -t boomtownroi/base:latest base

docker build -t boomtownroi/data-volume:latest data-volume

docker build -t boomtownroi/nodejs:latest nodejs

docker build -t boomtownroi/php-fpm:latest php-fpm

docker build -t boomtownroi/nginx:latest nginx

docker build -t boomtownroi/git:latest git

docker build -t boomtownroi/build:latest build

echo "ALL DONE!"
