#!/bin/bash

# This is for building and testing in development

docker build -t boomtownroi/base base

docker build -t boomtownroi/consul-ui consul-ui

docker build -t boomtownroi/consul-agent consul-agent

docker build -t boomtownroi/data-volume data-volume

docker build -t boomtownroi/mysql-dev mysql-dev

docker build -t boomtownroi/memcached memcached

docker build -t boomtownroi/nodejs nodejs

docker build -t boomtownroi/php5-fpm php5-fpm

docker build -t boomtownroi/nginx nginx

docker build -t boomtownroi/git git

echo "ALL DONE!"