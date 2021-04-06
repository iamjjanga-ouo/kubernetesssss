#!/bin/sh
trap "exit" SIGINT
mkdir /var/htdocs

RANDOM=$$
for i in `seq 1000`
do
  echo "for loop in "$RANDOM > /var/htdocs/index.html
  sleep 10
done