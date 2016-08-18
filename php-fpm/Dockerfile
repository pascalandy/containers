FROM boomtownroi/base:16.04

# Add your name if you find yourself here
MAINTAINER Robert Landers <rlanders@boomtownroi.com>

ENV ALLOW_DEBUG true

# Install nginx and have it forward logs to Docker
RUN add-apt-repository -y ppa:nginx/stable &2> /dev/null

RUN apt-get update && \
    apt-get install -y php-fpm php-mysql php-curl php-gd \
    php-intl php-pear php-imagick php-imap php-mcrypt php-memcached \
    g++ cpp php-dev \
    php-pspell php-recode php-tidy php-xmlrpc php-xsl php-xdebug netcat && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY root/build-v8.sh /build-v8.sh

RUN /build-v8.sh

COPY root /

RUN phpenmod opcache && phpdismod xdebug

VOLUME /var/run/fpm/
