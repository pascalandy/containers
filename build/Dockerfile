FROM boomtownroi/git

# Add your name if you find yourself here
MAINTAINER Robert Landers <rlanders@boomtownroi.com>

ENV NODE_VERSION 5.0.0
ENV HUB_VERSION 2.2.1
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
    php5 \
    python \
    rsync \
    ssh-client \
    wget \
    php5-fpm php5-mysql php-apc php5-curl php5-gd \
    php5-intl php-pear php5-imagick php5-imap php5-mcrypt php5-memcached php5-ming \
    php5-ps php5-pspell php5-recode php5-sqlite php5-tidy php5-xmlrpc php5-xsl php5-xdebug && \
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
    echo '{ "allow_root": true }' > /root/.bowerrc

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && chmod +x wp-cli.phar && mv wp-cli.phar /bin/wp
