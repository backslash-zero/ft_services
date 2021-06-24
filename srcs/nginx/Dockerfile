# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: celestin <celestin@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/01/07 16:39:56 by celestin          #+#    #+#              #
#    Updated: 2021/06/21 18:04:26 by celestin         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM		ft_services_nginx_base

LABEL		maintainer="Célestin (cmeunier@42.fr)"

RUN			apk update					&& \
			apk add openssl				&& \
			mkdir -p /var/www/html

RUN			openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
			-subj "/C=FR/ST=69/L=Lyon/O=42/CN=cmeunier"    		\
			-keyout /etc/ssl/private/nginx-selfsigned.key   	\
			-out /etc/ssl/certs/nginx-selfsigned.crt

ENV			PMAPORT=5000
ENV			WPPORT=5050
ENV			IP=127.0.0.1

COPY		srcs/exec/run.sh		/usr/sbin/
COPY		srcs/exec/pod_crash.sh	/usr/sbin/
COPY		srcs/nginx/default.conf	/etc/nginx/http.d/
COPY		srcs/html/index.html	/var/www/html/

EXPOSE		80 443

ENTRYPOINT	[ "run.sh" ]