#!/bin/bash
source "/vagrant/scripts/common.sh"

#https://github.com/GoogleCloudPlatform/kubernetes/blob/master/docs/getting-started-guides/fedora/fedora_manual_config.md

function setupKubernetes {
	echo "creating kubernetes environment variables"
	cp -f $KUBERNETES_RES_DIR/kubernetes.sh /etc/profile.d/kubernetes.sh
	cp -f $KUBERNETES_RES_DIR/startk8sslave.sh $KUBERNETES_PREFIX/server/bin/startk8sslave.sh
}

function installKubernetes {
	echo "install kubernetes"
	FILE=/vagrant/resources/$KUBERNETES_ARCHIVE
	if resourceExists $KUBERNETES_ARCHIVE; then
		echo "install kubernetes from local file"
	else
		curl -o $FILE -O -L $KUBERNETES_MIRROR_DOWNLOAD
	fi
	tar -xzf $FILE -C /usr/local
	tar -xzf $KUBERNETES_PREFIX/server/kubernetes-server-linux-amd64.tar.gz -C $KUBERNETES_PREFIX/server
	mv $KUBERNETES_PREFIX/server/kubernetes/server/bin $KUBERNETES_PREFIX/server
	rm -rf $KUBERNETES_PREFIX/server/kubernetes
}

echo "setup Kubernetes"
installKubernetes
setupKubernetes
