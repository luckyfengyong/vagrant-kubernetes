#!/bin/bash
source "/vagrant/scripts/common.sh"

#https://github.com/GoogleCloudPlatform/kubernetes/blob/master/docs/getting-started-guides/fedora/fedora_manual_config.md

function setupKubernetes {

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
}


echo "setup Kubernetes"
installKubernetes
setupKubernetes
