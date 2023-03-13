#!/bin/bash

if [ ! -d "/var/lib/mysql/${MARIADB_DATABASE}" ]; then

	mysql_install_db --user=mysql --datadir="/var/lib/mysql" > /dev/null

	chown -R mysql:mysql /var/lib/mysql

	service mysql start
	
	mysql --user=root --password="" <<_EOF_
	CREATE DATABASE ${MARIADB_DATABASE};
	USE ${MARIADB_DATABASE};
	GRANT ALL ON *.* TO '${MARIADB_USER}'@'%' IDENTIFIED BY '${MARIADB_PASSWORD}';
	GRANT ALL ON *.* TO '${MARIADB_USER}'@'localhost' IDENTIFIED BY '${MARIADB_PASSWORD}';
	FLUSH PRIVILEGES;
	DELETE FROM mysql.user WHERE User='';
	DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
	DROP DATABASE IF EXISTS test;
	DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';
	FLUSH PRIVILEGES;
	ALTER USER 'root'@'localhost' IDENTIFIED BY '${MARIADB_ROOT_PASSWORD}';
	FLUSH PRIVILEGES;
_EOF_

	sed -i "s/password =/password = ${MARIADB_ROOT_PASSWORD}/g" /etc/mysql/debian.cnf
	
	service mysql stop
fi

/usr/bin/mysqld_safe --user=mysql --datadir=/var/lib/mysql