#!/bin/bash

# This is for building and testing in development

cd base
docker build -t boomtownroi/base .
cd ..

cd consul-ui
docker build -t boomtownroi/consul-ui .
cd ..

