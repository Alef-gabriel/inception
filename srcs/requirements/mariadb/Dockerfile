FROM debian:buster

RUN apt-get update && apt-get upgrade -y

RUN	apt-get install -y mariadb-server

RUN rm /etc/mysql/mariadb.conf.d/50-server.cnf

COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d

RUN chmod 644 /etc/mysql/mariadb.conf.d/50-server.cnf

COPY scripts/start.sh /tmp

ENTRYPOINT ["/bin/sh", "/tmp/start.sh"]
