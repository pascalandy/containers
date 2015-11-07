FROM boomtownroi/base

# Add your name if you find yourself here
MAINTAINER Robert Landers <landers.robert@gmail.com>

ENV NODE_VERSION 4.2.2
ENV NPM_VERSION 3.3.6
ENV NVM_SYMLINK_CURRENT "true"

# Setup Node.js (Setup NodeSource Official PPA)
# https://github.com/nodesource/docker-node/blob/master/ubuntu/trusty/Dockerfile
RUN buildDeps='curl lsb-release python-all git apt-transport-https' && \
    apt-get update && \
    apt-get install -y --force-yes $buildDeps && \
    curl -sL https://deb.nodesource.com/setup | bash - && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN touch /.profile && curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.25.4/install.sh | NVM_DIR=/usr/local/nvm PROFILE=/.profile bash
RUN . /.profile && nvm install $NODE_VERSION && nvm use $NODE_VERSION && nvm alias default $NODE_VERSION
RUN . /.profile && npm install -g npm && npm install -g forever