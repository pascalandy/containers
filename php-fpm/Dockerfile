FROM boomtownroi/base:16.04

# Add your name if you find yourself here
MAINTAINER Robert Landers <rlanders@boomtownroi.com>

ENV ALLOW_DEBUG true

# Install nginx and have it forward logs to Docker
RUN add-apt-repository -y ppa:nginx/stable &2> /dev/null

RUN apt-get update && \
    add-apt-repository ppa:pinepain/libv8-5.2 && \
    apt-get update && \
    apt-get install -y libv8-5.2 && \
    apt-get update && \
    apt-get install -y php-fpm php-mysql php-curl php-gd \
    php-intl php-pear php-imagick php-imap php-mcrypt php-memcached \
    libv8-dev g++ cpp php-dev \
    php-pspell php-recode php-tidy php-xmlrpc php-xsl php-xdebug netcat && \
    pecl install v8js && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

ADD root /

RUN phpenmod opcache

VOLUME /var/run/fpm/