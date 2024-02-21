FROM php:8-apache
# LABEL Maintainer="codicier" \
#       Description="Micro GPodder server Apache2"

RUN a2enmod ssl && a2enmod rewrite
RUN mkdir -p /etc/apache2/ssl

COPY php/php.ini /usr/local/etc/php/php.ini
COPY ./ssl/*.pem /etc/apache2/ssl/
COPY ./apache/000-default.conf /etc/apache2/sites-available/000-default.conf

# # Setup document root
RUN mkdir -p /var/www
RUN mkdir -p /var/www/html
RUN mkdir -p /var/www/html/data

# # Add application
WORKDIR /var/www/html/
COPY server /var/www/html/

EXPOSE 80
EXPOSE 443

VOLUME ["/var/www/html/data"]
