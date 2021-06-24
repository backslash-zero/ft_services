# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: celestin <celestin@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/01/06 12:18:40 by celestin          #+#    #+#              #
#    Updated: 2021/06/21 18:04:44 by celestin         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM		ft_services_nginx_base

LABEL		maintainer="Célestin (cmeunier@42.fr)"

RUN			apk update  																&&	\
			apk add --no-cache supervisor php7 php-fpm php7-common							\
    		php7-iconv php7-json php7-gd php7-curl php7-openssl php7-xml php7-mysqli		\
    		php7-pdo php7-pdo_mysql php7-soap php7-xmlrpc php7-mcrypt php7-gettext			\
    		php7-ctype php7-dom php7-phar													\
			curl

RUN			wget -P /tmp https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar  &&	\
			chmod +x /tmp/wp-cli.phar && mv /tmp/wp-cli.phar /usr/sbin/wp

ARG			WP_VERSION="wordpress-5.6"
ARG			WP_FILE="${WP_VERSION}.tar.gz"

RUN 		wget https://wordpress.org/${WP_FILE}   && \
    		tar -xzf ${WP_FILE}                     && \
    		mv wordpress /var/www/                  && \
    		rm -rf ${WP_FILE}

COPY		srcs/nginx/default.conf					/etc/nginx/http.d/
COPY		srcs/supervisord.conf					/etc/
COPY		srcs/exec/run.sh						/usr/sbin
COPY		srcs/exec/wordpress_install.sh			/usr/sbin
COPY		srcs/exec/pod_crash.sh					/usr/sbin/

EXPOSE		5050

ENTRYPOINT	[ "run.sh" ]