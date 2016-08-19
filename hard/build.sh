#!/bin/bash

set -x

base() {
	# create *min files for apt* and dpkg* in order to avoid issues with locales
	# and interactive interfaces
	ls /usr/bin/apt* /usr/bin/dpkg* |                                      \
	while read line; do                                                    \
		min=$line-min;                                                     \
		printf '#!/bin/sh\n/usr/bin/apt-dpkg-wrapper '$line' $@\n' > $min; \
		chmod +x $min;                                                     \
	done

	##
	## PREPARE
	##

	# temporarily disable dpkg fsync to make building faster.
	if [ ! -e /etc/dpkg/dpkg.cfg.d/docker-apt-speedup ]; then             \
		echo force-unsafe-io > /etc/dpkg/dpkg.cfg.d/docker-apt-speedup; \
	fi

	# prevent initramfs updates from trying to run grub and lilo.
	# https://journal.paul.querna.org/articles/2013/10/15/docker-ubuntu-on-rackspace/
	# http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=594189
	export INITRD=no

	# enable Ubuntu Universe and Multiverse.
	sed -i 's/^#\s*\(deb.*universe\)$/\1/g' /etc/apt/sources.list   && \
	sed -i 's/^#\s*\(deb.*multiverse\)$/\1/g' /etc/apt/sources.list && \
	apt-get-min update

	# fix some issues with APT packages.
	# see https://github.com/dotcloud/docker/issues/1024
	dpkg-divert-min --local --rename --add /sbin/initctl && \
		ln -sf /bin/true /sbin/initctl

	# replace the 'ischroot' tool to make it always return true.
	# prevent initscripts updates from breaking /dev/shm.
	# https://journal.paul.querna.org/articles/2013/10/15/docker-ubuntu-on-rackspace/
	# https://bugs.launchpad.net/launchpad/+bug/974584
	dpkg-divert-min --local --rename --add /usr/bin/ischroot && \
		ln -sf /bin/true /usr/bin/ischroot

	# install HTTPS support for APT.
	apt-get-install-min apt-transport-https ca-certificates wget

	# install add-apt-repository
	apt-get-install-min software-properties-common

	# upgrade all packages.
	apt-get-min dist-upgrade -y --no-install-recommends

	# fix locale.
	export LANG=en_US.UTF-8
	export LC_CTYPE=en_US.UTF-8
	apt-get-install-min language-pack-en        && \
		locale-gen en_US                        && \
		update-locale LANG=$LANG LC_CTYPE=$LC_CTYPE

	# s6 overlay
	tar xvfz /tmp/s6-overlay.tar.gz -C /
}

nginx() {
	apt-get update
	apt-get install -y wget
	mkdir -p /etc/apt/sources.list.d
	touch /etc/apt/sources.list.d/nginx.list
	echo "deb http://nginx.org/packages/mainline/ubuntu/ trusty nginx" >> /etc/apt/sources.list.d/nginx.list
	echo "deb-src http://nginx.org/packages/mainline/ubuntu/ trusty nginx" >> /etc/apt/sources.list.d/nginx.list
	wget -q -O- http://nginx.org/keys/nginx_signing.key | apt-key add -
	apt-get remove --purge -y wget
	apt-get autoremove -y

	apt-get install -y nginx dnsmasq
	apt-get clean
	rm -rf /var/lib/apt/lists/*
	ln -sf /dev/stdout /var/log/nginx/access.log
	ln -sf /dev/stderr /var/log/nginx/error.log
}

php() {
	add-apt-repository -y ppa:nginx/stable &2> /dev/null
	apt-get update
    apt-get install -y php-fpm php-mysql php-curl php-gd \
    php-intl php-pear php-imagick php-imap php-mcrypt php-memcached \
    g++ cpp php-dev \
    php-pspell php-recode php-tidy php-xmlrpc php-xsl php-xdebug netcat
    apt-get clean
    rm -rf /var/lib/apt/lists/*

    /build-v8.sh
}

node() {
	buildDeps='curl lsb-release python-all git apt-transport-https build-essential'
	apt-get update
	apt-get install -y --force-yes $buildDeps
	curl -sL https://deb.nodesource.com/setup | bash -
	apt-get clean
	rm -rf /var/lib/apt/lists/*

	curl -L http://git.io/n-install | N_PREFIX=/usr/local/n bash -s -- -y $NODE_VERSION

	npm_install=$NPM_VERSION curl -L https://www.npmjs.com/install.sh | sh

	npm install -g forever
	ln -s /usr/bin/nodejs /usr/bin/node
	npm config set color false
}

if [ "$1" == "base" ]; then
	base
fi

if [ "$1" == "nginx" ]; then
	nginx
fi

if [ "$1" == "php" ]; then
	php
fi

if [ "$1" == "node" ]; then
	node
fi
