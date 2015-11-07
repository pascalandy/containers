#!/bin/bash

# This is for building and testing in development

cd base
docker build -t boomtownroi/base .
cd ..

cd consul-ui
docker build -t boomtownroi/consul-ui .
cd ..

cd consul-agent
docker build -t boomtownroi/consul-agent .
cd ..

cd data-volume
docker build -t boomtownroi/data-volume .
cd ..

