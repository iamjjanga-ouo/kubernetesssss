#!/bin/bash
# Prerequisite
#
# Test in Ubuntu 18.04.5 LTS (Bionic Beaver)
# Kubernetes server "v1.20.5"
#
## (in n-worker node) install 'nfs-common' package
apt-get update && apt-get install nfs-common -y
#
## (in nfs-server instance(machine))
# install 'nfs-common', 'nfs-kernel-server', 'rpcbind' packages
apt-get update && apt-get install nfs-common nfs-kernel-server rpcbind -y
