# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: celestin <celestin@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/06/20 21:50:21 by celestin          #+#    #+#              #
#    Updated: 2021/06/22 15:54:52 by celestin         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM		alpine:3.12.3

LABEL		maintainer="Célestin (cmeunier@42.fr)"

ARG         PHPMA_VERSION="5.0.4"
ARG         PHPMA_FILE="phpMyAdmin-${PHPMA_VERSION}-all-languages.tar.gz"

WORKDIR     /tmp

RUN         apk add --no-cache                                              \
            nginx                                                           \
            php7 php7-fpm  php7-opcache php7-gd php7-mysqli php7-zlib       \
            php7-curl php7-mbstring php7-json php7-session php7-bz2 php-zip \
            openssl                                                         \
            bash

RUN         wget https://files.phpmyadmin.net/phpMyAdmin/${PHPMA_VERSION}/${PHPMA_FILE}

RUN			openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
			-subj "/C=FR/ST=69/L=Lyon/O=42/CN=cmeunier"    		\
			-keyout /etc/ssl/private/nginx-selfsigned.key   	\
			-out /etc/ssl/certs/nginx-selfsigned.crt

COPY        srcs/exec/run.sh        /usr/sbin/
COPY		srcs/exec/pod_crash.sh	/usr/sbin/
COPY        srcs/default.conf       /etc/nginx/conf.d/default.conf

ENTRYPOINT  [ "/usr/sbin/run.sh" ]