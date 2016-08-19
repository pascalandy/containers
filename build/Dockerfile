FROM boomtownroi/git:16.04

# Add your name if you find yourself here
MAINTAINER Robert Landers <rlanders@boomtownroi.com>

ENV NODE_VERSION 5.0.0
ENV HUB_VERSION 2.2.1
ENV NPM_VERSION 3.4.0
ENV PHANTOMJS_BIN /usr/local/n/lib/node_modules/phantomjs/lib/phantom/bin/phantomjs

RUN add-apt-repository -y ppa:nginx/stable &2> /dev/null

RUN apt-get update && \
    apt-get install -y \
    build-essential \
    curl \
    dialog \
    gawk \
    jq \
    imagemagick \
    libfontconfig \
    libssl-dev \
    mysql-client \
    php \
    python \
    rsync \
    ssh-client \
    wget \
    php-fpm php-mysql php-curl php-gd \
    php-intl php-pear php-imagick php-imap php-mcrypt php-memcached \
    php-pspell php-recode php-tidy php-xmlrpc php-xsl php-xdebug && \
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
    webpack \
    karma-cli@0.1.1 \
    argus-eyes \
    npm-cache@0.3.7 \
    phantomjs@1.9.18 && \
    ln -s /usr/bin/nodejs /usr/bin/node && \
    npm config set color false && \
    echo '{ "allow_root": true, "interactive": false }' > /root/.bowerrc

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && chmod +x wp-cli.phar && mv wp-cli.phar /bin/wp
