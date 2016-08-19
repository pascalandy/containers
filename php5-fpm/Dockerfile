FROM boomtownroi/base

# Add your name if you find yourself here
MAINTAINER Robert Landers <rlanders@boomtownroi.com>

ENV ALLOW_DEBUG true

# Install nginx and have it forward logs to Docker
RUN add-apt-repository -y ppa:nginx/stable &2> /dev/null

RUN apt-get update && apt-get install -y wget php5-fpm php5-mysql php-apc php5-curl php5-gd \
    php5-intl php-pear php5-imagick php5-imap php5-mcrypt php5-memcached php5-ming \
    libv8-dev g++ cpp php5-dev \
    php5-ps php5-pspell php5-recode php5-sqlite php5-tidy php5-xmlrpc php5-xsl php5-xdebug netcat && \
    pecl install v8js-0.1.3 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN wget https://phar.phpunit.de/phpunit.phar
RUN chmod +x phpunit.phar
RUN mv phpunit.phar /usr/local/bin/phpunit

ADD root /

RUN php5enmod opcache

VOLUME /var/run/fpm/