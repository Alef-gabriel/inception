#!/bin/bash

ls | grep -v start.sh | xargs rm -rf

export WP_CLI_CACHE_DIR=/var/www/wordpress/.wp-cli/cache

wp core download
wp core config \
    --dbname=$MARIADB_DATABASE \
    --dbuser=$MARIADB_USER \
    --dbpass=$MARIADB_PASSWORD \
    --dbhost=$MARIADB_ROOT_HOST \
    --dbprefix='wp_' \
    --dbcharset="utf8" \
    --dbcollate="utf8_general_ci"

wp core install \
    --url=$DOMAIN_NAME \
    --title=$WP_TITLE \
    --admin_user=$WP_ADMIN_USR \
    --admin_password=$WP_ADMIN_PWD \
    --admin_email=$WP_ADMIN_EMAIL \
    --skip-email

wp user create $WP_USR $WP_EMAIL --user_pass=$WP_PWD --role=subscriber

/usr/sbin/php-fpm7.3 --nodaemonize