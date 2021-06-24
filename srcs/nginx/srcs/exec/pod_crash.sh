#!/bin/bash

pgrep nginx
if [ "$?" -ne 0 ]; then
  echo "nginx has already exited."
  exit 1
fi

echo "everything running as expected in pod nginx"