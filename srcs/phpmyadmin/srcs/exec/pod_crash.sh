#!/bin/bash

echo "pod crash test"
pgrep nginx
if [ "$?" -ne 0 ]; then
    echo "nginx process killed — we need to crash the pod :'( "
    exit 1
fi
pgrep php-fpm
if [ "$?" -ne 0 ]; then
    echo "php-fpm process killed — we need to crash the pod :'( "
    exit 1
fi
echo "everything running as expected in pod phpmyadmin"
exit 0