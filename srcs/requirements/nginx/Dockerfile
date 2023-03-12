FROM debian:buster

RUN apt-get update && apt-get upgrade -y

RUN	apt-get install -y nginx

COPY conf/certs /etc/ssl/certs

COPY conf/algabrie.conf /etc/nginx/sites-available/algabrie

RUN ln -s /etc/nginx/sites-available/algabrie /etc/nginx/sites-enabled/algabrie

RUN	rm /var/www/html/index.nginx-debian.html

ENTRYPOINT ["nginx", "-g", "daemon off;"]