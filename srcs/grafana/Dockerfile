# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: celestin <celestin@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/06/21 17:02:36 by celestin          #+#    #+#              #
#    Updated: 2021/06/21 17:02:45 by celestin         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM 		alpine:latest

LABEL		maintainer="Célestin (cmeunier@42.fr)"

WORKDIR		/usr/share/grafana

RUN			apk update							&& \
			apk add	grafana						&& \
			mkdir /usr/share/grafana/dashboards	&& \
			rm -rf /var/cache/apk/*

COPY		srcs/provisioning/datasources/grafana_datasource.yaml		/usr/share/grafana/conf/provisioning/datasources/
COPY		srcs/provisioning/datasources/grafana_provider.yaml			/usr/share/grafana/conf/provisioning/dashboards/default.yaml
COPY		srcs/provisioning/dashboards/*								/usr/share/grafana/dashboards/
COPY		srcs/grafana.ini											/usr/share/grafana/conf/grafana.ini

EXPOSE      3000

ENTRYPOINT [ "/usr/sbin/grafana-server", "--config", "conf/grafana.ini" ]