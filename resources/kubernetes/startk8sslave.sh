#!/bin/bash

_MY_IPADDR=$(/sbin/ifconfig eth1 | grep 'inet addr:'| grep -v '127.0.0.1' | cut -d: -f2 | sort | awk '{print $1}')

setsid $KUBERNETES_HOME/server/bin/kubelet \
--address=$_MY_IPADDR \
--port=10250 \
--hostname_override=$_MY_IPADDR \
--etcd_servers=http://10.211.57.101:4001 \
--logtostderr=true \
--v=0 \
--allow_privileged=false >"/tmp/kubelet.log" 2>&1 &

echo "started kubelet"

setsid $KUBERNETES_HOME/server/bin/kube-proxy \
--v=0 \
--master="http://10.211.57.101:4001" >"/tmp/kube-proxy.log" 2>&1 &

echo "started kube-proxy"

