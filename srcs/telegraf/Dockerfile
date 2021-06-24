# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: celestin <celestin@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/06/21 17:03:11 by celestin          #+#    #+#              #
#    Updated: 2021/06/21 17:08:04 by celestin         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM		alpine:latest

LABEL		maintainer="Célestin (cmeunier@42.fr)"

ENV			TELEGRAF_VERSION 1.13.3

ENV			INFLUX_IP influxdb-service:8086

RUN			wget https://dl.influxdata.com/telegraf/releases/telegraf-${TELEGRAF_VERSION}-static_linux_amd64.tar.gz	&& \
			tar -C . -xzf telegraf-${TELEGRAF_VERSION}-static_linux_amd64.tar.gz									&& \
        	chmod +x telegraf/*																						&& \
        	cp telegraf/telegraf /usr/bin/																			&& \
        	rm -rf *.tar.gz* telegraf/																				&& \
			mkdir /etc/telegraf/																

COPY		srcs/exec/run.sh			/usr/sbin

COPY		srcs/telegraf.conf	/etc/telegraf/telegraf.conf

ENTRYPOINT [ "/usr/bin/telegraf" ]