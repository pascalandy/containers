FROM boomtownroi/base:phantomize

# Add your name if you find yourself here
MAINTAINER Robert Landers <rlanders@boomtownroi.com>

VOLUME /.ssh_host

RUN apt-get install -y git && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN  echo "    IdentityFile /.ssh/id_rsa" >> /etc/ssh/ssh_config

CMD 'git'
