#!/bin/bash

#ssh
SSH_RES_DIR=/vagrant/resources/ssh
RES_SSH_COPYID_ORIGINAL=$SSH_RES_DIR/ssh-copy-id.original
RES_SSH_COPYID_MODIFIED=$SSH_RES_DIR/ssh-copy-id.modified
RES_SSH_CONFIG=$SSH_RES_DIR/config
#etcd
ETCD_PREFIX=/usr/local/etcd
ETCD_VERSION=v2.0.0
ETCD_ARCHIVE=etcd-$ETCD_VERSION-linux-amd64.tar.gz
ETCD_MIRROR_DOWNLOAD=https://github.com/coreos/etcd/releases/download/$ETCD_VERSION/$ETCD_ARCHIVE
ETCD_RES_DIR=/vagrant/resources/etcd
#kubernetes
KUBERNETES_PREFIX=/usr/local/kubernetes
KUBERNETES_VERSION=v0.9.1
KUBERNETES_ARCHIVE=kubernetes.tar.gz
KUBERNETES_MIRROR_DOWNLOAD=https://github.com//GoogleCloudPlatform/kubernetes/releases/download/$KUBERNETES_VERSION/$KUBERNETES_ARCHIVE
KUBERNETES_RES_DIR=/vagrant/resources/kubernetes

function resourceExists {
	FILE=/vagrant/resources/$1
	if [ -e $FILE ]
	then
		return 0
	else
		return 1
	fi
}

function fileExists {
	FILE=$1
	if [ -e $FILE ]
	then
		return 0
	else
		return 1
	fi
}

#echo "common loaded"
