#!/bin/bash

# This is for building and testing in development

docker build -t boomtownroi/base base

docker build -t boomtownroi/consul-ui consul-ui

docker build -t boomtownroi/consul-agent consul-agent

docker build -t boomtownroi/data-volume data-volume

docker build -t boomtownroi/mysql-dev mysql-dev