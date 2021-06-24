# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: cmeunier <cmeunier@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/01/06 11:13:16 by celestin          #+#    #+#              #
#    Updated: 2021/01/12 17:03:13 by cmeunier         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM		alpine:latest

LABEL		maintainer="Célestin (cmeunier@42.fr)"

ENV			minikube_ip=$minikube_ip

RUN			apk update &&	\
			apk add --no-cache mysql mysql-client

COPY		srcs/exec/run.sh			usr/sbin/run.sh
COPY		srcs/exec/init_db.sh		usr/sbin/init_db.sh

EXPOSE		3306

ENTRYPOINT	[ "run.sh" ]