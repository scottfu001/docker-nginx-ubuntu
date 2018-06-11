FROM ubuntu:bionic
MAINTAINER  Scott Fu <scott.fu@outlook.com>

# install common
RUN apt-get update && apt-get install -y software-properties-common

# Install Nginx.
RUN \
  add-apt-repository -y ppa:nginx/stable && \
  apt-get update && \
  apt-get install -y nginx && \
  # for docker
  echo "\ndaemon off;" >> /etc/nginx/nginx.conf && \
  chown -R www-data:www-data /var/lib/nginx && \
  chown -R www-data:www-data /var/www/html

# mountable directories.
VOLUME ["/etc/nginx/sites-enabled", "/etc/nginx/conf.d", "/var/log/nginx", "/var/www/html", "/etc/nginx/certs"]

# working directory.
WORKDIR /etc/nginx

# clean up
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && apt-get autoremove

# Define default command.
CMD ["nginx"]

# ports.
EXPOSE 80
EXPOSE 443
