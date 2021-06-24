# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: celestin <celestin@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/01/18 10:55:31 by cmeunier          #+#    #+#              #
#    Updated: 2021/06/20 21:54:01 by celestin         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM		alpine:latest

LABEL		maintainer="Célestin (cmeunier@42.fr)"

RUN			apk update                  &&	\
			apk add --no-cache	gettext		\
            					openssl		\
            					vsftpd

RUN			openssl req -x509 -nodes -days 365 -newkey rsa:2048		\
						-subj "/C=FR/ST=69/L=Lyon/O=42/CN=cmeunier"	\
						-keyout /etc/ssl/private/vsftpd.key			\
						-out /etc/ssl/certs/vsftpd.crt

COPY        srcs/exec/run.sh	usr/sbin/run.sh
COPY        ./srcs/vsftpd.conf	/tmp/vsftpd.conf

EXPOSE      20 21 30000

ENTRYPOINT	[ "run.sh" ]