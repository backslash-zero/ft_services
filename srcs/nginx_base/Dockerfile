# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: celestin <celestin@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/01/06 11:37:55 by celestin          #+#    #+#              #
#    Updated: 2021/06/22 15:54:37 by celestin         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM		alpine:latest

LABEL		maintainer="Célestin (cmeunier@42.fr)"

RUN			apk update                  &&	\
			apk add --no-cache nginx    &&	\
			apk add --no-cache bash		&&	\
			mkdir -p /run/nginx