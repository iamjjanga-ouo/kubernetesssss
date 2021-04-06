#!/bin/bash

LIMIT=100
i=0

# create nfs-httpd Pod
kubectl create -f nfs-httpd.yaml

# Check running state of the Pod
while [ $i -le $LIMIT ]
do
  if [[ $(kubectl get pod | awk 'FNR == 2{ print $3 }') == "Running" ]]; then
    break
  fi
  echo 'Wait Pod status is Running...'$i
  sleep 1
  i=$(($i+1))
done

echo 'Pod is Running!'

# Port-forward BackGround
if [[ -z "${PORT}" ]]; then # check Port environment variable is set
  PORT=8080
fi
kubectl port-forward nfs-httpd $PORT:80 &

sleep 2

# check index.html
curl 127.0.0.1:$PORT

# Go to nfs-server and Make new index.html in nfs directory then check!
