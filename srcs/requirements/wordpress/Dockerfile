FROM debian:buster

RUN apt-get update && apt-get upgrade -y

RUN apt-get install -y php php7.3-fpm php-pear php-cgi php-common php-zip php-mbstring php-net-socket php-gd php-xml-util php-mysql php-gettext php-bcmath wget mariadb-client

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

RUN chmod +x wp-cli.phar

RUN mv wp-cli.phar /usr/local/bin/wp

RUN mkdir /run/php

RUN sed -i "s/listen = \/run\/php\/php7.3-fpm.sock/listen = 9000/" /etc/php/7.3/fpm/pool.d/www.conf

RUN touch /var/log/php7.3-fpm.log

COPY scripts/start.sh /var/www/wordpress/start.sh

RUN chown -R www-data:www-data /run/php /var/log/php7.3-fpm.log /var/www/wordpress

USER www-data

WORKDIR /var/www/wordpress/

ENTRYPOINT ["/bin/sh", "start.sh"]