FROM boomtownroi/base:latest

# Add your name if you find yourself here
MAINTAINER Robert Landers <landers.robert@gmail.com>

ENV NODE_VERSION 5.0.0
ENV NPM_VERSION 3.3.11

# Setup Node.js (Setup NodeSource Official PPA)
# https://github.com/nodesource/docker-node/blob/master/ubuntu/trusty/Dockerfile
RUN buildDeps='curl lsb-release python-all git apt-transport-https build-essential' && \
    apt-get update && \
    apt-get install -y --force-yes $buildDeps && \
    curl -sL https://deb.nodesource.com/setup | bash - && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN curl -L http://git.io/n-install | N_PREFIX=/usr/local/n bash -s -- -y $NODE_VERSION
ENV PATH "$PATH:/usr/local/n/bin"

RUN npm_install=$NPM_VERSION curl -L https://www.npmjs.com/install.sh | sh

RUN npm install -g forever \
    && ln -s /usr/bin/nodejs /usr/bin/node \
    && npm config set color false
