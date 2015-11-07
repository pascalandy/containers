FROM boomtownroi/base

# Add your name if you find yourself here
MAINTAINER Robert Landers <rlanders@boomtownroi.com>

# Install nginx and have it forward logs to Docker
RUN add-apt-repository -y ppa:nginx/stable &2> /dev/null

RUN apt-get update && \
    apt-get install -y nginx dnsmasq && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    chown -R www-data:www-data /var/lib/nginx && \
    ln -sf /dev/stdout /var/log/nginx/access.log && \
    ln -sf /dev/stderr /var/log/nginx/error.log

# Add the files
ADD root /

# Expose the ports for nginx
EXPOSE 80
EXPOSE 443