##########################################################################################
#	Dockerfile	
#						                                    
#	Version 0.1
#	by:@mvaldeta
#	Project: ft_server
#
#	enjoy :)
##########################################################################################
#	Our container
#########################################################################################
FROM debian:buster
RUN apt-get update && apt-get upgrade -y

#########################################################################################
#	Necessary dependencies, add as you please
#########################################################################################
RUN apt-get install -y nginx mariadb-server openssl vim
RUN	apt-get install -y php7.3 php-mysql php-fpm php-pdo php-gd php-cli php-mbstring
RUN apt-get install -y wget 
RUN wget https://files.phpmyadmin.net/phpMyAdmin/5.0.1/phpMyAdmin-5.0.1-english.tar.gz
RUN wget https://wordpress.org/latest.tar.gz

#########################################################################################
#	KEY
#########################################################################################
RUN openssl req -x509 -nodes -days 365 \
	-newkey rsa:2048 -subj "/C=PT/ST=Portugal/L=Lisboa/O=42Lisboa/CN=mvaldeta" \
	-keyout /etc/ssl/private/mvaldeta.key \
	-out /etc/ssl/certs/mvaldeta.crt

#########################################################################################
#	PHP
#########################################################################################
RUN mv phpMyAdmin-5.0.1-english.tar.gz /var/www/html/
WORKDIR /var/www/html/
RUN tar -xf phpMyAdmin-5.0.1-english.tar.gz && rm -rf phpMyAdmin-5.0.1-english.tar.gz
RUN mv phpMyAdmin-5.0.1-english phpmyadmin
COPY ./srcs/config.inc.php /var/www/html/phpmyadmin

#########################################################################################
#	WORD-PRESS
#########################################################################################
WORKDIR /
COPY ./srcs/wp-config.php /var/www/html
RUN mv latest.tar.gz /var/www/html/
WORKDIR /var/www/html/
RUN tar -xvzf latest.tar.gz && rm -rf latest.tar.gz
RUN mkdir -p autoindex
WORKDIR /var/www/html/autoindex
RUN touch a b c d e 

#########################################################################################
#	PERMISSIONS
#########################################################################################
RUN chown -R www-data:www-data /var/www/html                        
RUN chmod -R 755 /var/www/html
RUN openssl req -x509 -nodes -days 365 -subj "/C=PT/ST=Lisbon/L=Lisbon/O=42/OU=42Lisboa/CN=mvaldeta" -newkey rsa:2048 -keyout /etc/ssl/nginx-selfsigned.key -out /etc/ssl/nginx-selfsigned.crt;

#########################################################################################
#	COPY START.SH TO TMP
#########################################################################################
COPY ./srcs/init.sh /root/
COPY ./srcs/autoindex.sh /root/
RUN chmod +x /root/autoindex
#########################################################################################
#	NGINX CONFIG
#########################################################################################
COPY ./srcs/default /root/default.template
#RUN rm /var/www/html/index.nginx.html
COPY ./srcs/index.nginx.html /var/www/html/
RUN ln -sf /etc/nginx/sites-available/default /etc/nginx/sites-enabled

#########################################################################################
#	START.SH
#########################################################################################
WORKDIR /root

ENV AUTOINDEX=on
ENV DOLLAR='$'

RUN apt-get install -y gettext-base
CMD bash /root/init.sh
#########################################################################################
#	ADD MORE STUFF IF YOU NEED :)
#########################################################################################
