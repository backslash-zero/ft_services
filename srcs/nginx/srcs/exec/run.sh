#!/bin/bash

sed -i s/IP/$IP/g           /etc/nginx/http.d/default.conf;
sed -i s/WPPORT/$WPPORT/g   /etc/nginx/http.d/default.conf;
sed -i s/PMAPORT/$PMAPORT/g /etc/nginx/http.d/default.conf;

nginx -g "daemon off;"

sleep infinity