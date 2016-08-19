FROM boomtownroi/git:latest

# Add your name if you find yourself here
MAINTAINER Robert Landers <rlanders@boomtownroi.com>

ENV NODE_VERSION 5.0.0
ENV HUB_VERSION 2.2.5
ENV NPM_VERSION 3.10.5
ENV PHANTOMJS_BIN /usr/local/n/lib/node_modules/phantomjs-prebuilt/lib/phantom/bin/phantomjs

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
  wget https://github.com/github/hub/releases/download/v$HUB_VERSION/hub-linux-amd64-$HUB_VERSION.tgz && \
  tar -xvf hub-linux-amd64-$HUB_VERSION.tgz && \
  rm -f hub-linux-amd64-$HUB_VERSION.tgz && \
  cp hub-linux-amd64-$HUB_VERSION/bin/hub /bin/hub && \
  cp -r hub-linux-amd64-$HUB_VERSION/etc /etc && \
  rm -rf hub-linux-amd64-$HUB_VERSION

# Install node deps
RUN npm_install=$NPM_VERSION curl -L https://www.npmjs.com/install.sh | npm_install=$NPM_VERSION sh

RUN npm install -g \
    bower@1.7.9 \
    coffee-script \
    grunt-cli \
    jshint@2.9.2 \
    gulp \
    webpack \
    karma-cli@1.0.1 \
    phantomjs-prebuilt@2.1.7 && \
    ln -s /usr/bin/nodejs /usr/bin/node && \
    npm config set color false && \
    echo '{ "allow_root": true, "interactive": false }' > /root/.bowerrc && \
    npm cache clear # Make sure we clear npm's cache so it won't infest future builds

# See https://github.com/npm/npm/issues/9863#issuecomment-210185190 for the reason this must exist
RUN cd $(npm root -g)/npm \
 && npm install fs-extra \
 && sed -i -e s/graceful-fs/fs-extra/ -e s/fs\.rename/fs.move/ ./lib/utils/rename.js

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && chmod +x wp-cli.phar && mv wp-cli.phar /bin/wp
