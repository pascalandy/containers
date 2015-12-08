FROM boomtownroi/git

# Add your name if you find yourself here
MAINTAINER Robert Landers <rlanders@boomtownroi.com>

ENV NODE_VERSION 5.0.0
ENV HUB_VERSION 2.2.1
ENV NPM_VERSION 3.3.11
ENV PHANTOMJS_BIN /usr/local/n/lib/node_modules/phantomjs/lib/phantom/bin/phantomjs

RUN apt-get update && \
    apt-get install -y \
    build-essential \
    curl \
    dialog \
    gawk \
    jq \
    libfontconfig \
    libssl-dev \
    mysql-client \
    php5 \
    python \
    rsync \
    ssh-client \
    wget && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install node
RUN curl -L http://git.io/n-install | N_PREFIX=/usr/local/n bash -s -- -y $NODE_VERSION
ENV PATH "$PATH:/usr/local/n/bin"

# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/bin --filename=composer

# Install hub
RUN cd / && \
  wget https://github.com/github/hub/releases/download/v2.2.1/hub-linux-amd64-$HUB_VERSION.tar.gz && \
  tar -xvf hub-linux-amd64-$HUB_VERSION.tar.gz && \
  rm -f hub-linux-amd64-$HUB_VERSION.tar.gz && \
  cp hub-linux-amd64-$HUB_VERSION/hub /bin/hub && \
  cp -r hub-linux-amd64-$HUB_VERSION/etc /etc && \
  rm -rf hub-linux-amd64-$HUB_VERSION

# Install node deps
RUN npm_install=$NPM_VERSION curl -L https://www.npmjs.com/install.sh | npm_install=$NPM_VERSION sh
RUN npm install -g \
    bower@1.6.5 \
    coffee-script \
    grunt-cli \
    gulp \
    karma-cli@0.1.1 \
    npm-cache \
    phantomjs@1.9.18 && \
    ln -s /usr/bin/nodejs /usr/bin/node && \
    npm config set color false

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && chmod +x wp-cli.phar && mv wp-cli.phar /bin/wp