#!/bin/bash

ETCD_VER=v3.4.14

# choose either URL
GOOGLE_URL=https://storage.googleapis.com/etcd
GITHUB_URL=https://github.com/etcd-io/etcd/releases/download
DOWNLOAD_URL=${GOOGLE_URL}

rm -f $HOME/etcd-${ETCD_VER}-linux-amd64.tar.gz
rm -rf $HOME/etcd && mkdir -p $HOME/etcd

curl -L ${DOWNLOAD_URL}/${ETCD_VER}/etcd-${ETCD_VER}-linux-amd64.tar.gz -o $HOME/etcd-${ETCD_VER}-linux-amd64.tar.gz
tar xzvf $HOME/etcd-${ETCD_VER}-linux-amd64.tar.gz -C $HOME/etcd --strip-components=1
rm -f $HOME/etcd-${ETCD_VER}-linux-amd64.tar.gz

$HOME/etcd/etcd --version
$HOME/etcd/etcdctl version

CA="/etc/kubernetes/ssl/kube-ca.pem"
CERT=$(ls /etc/kubernetes/ssl/kube-etcd-*.pem | grep -v key)
KEY=$(ls /etc/kubernetes/ssl/kube-etcd-*-key.pem)
FILE=etcd-salud-$(hostname).log

# GET etcd health
sudo $HOME/etcd/etcdctl endpoint health --endpoints=https://127.0.0.1:2379 --cacert=$CA --cert=$CERT --key=$KEY 2>&1 | tee $FILE
printf "\n\nEnviar archivo etcd-salud.log\n\n"

