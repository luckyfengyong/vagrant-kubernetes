#!/bin/bash

_MY_IPADDR=$(/sbin/ifconfig eth1 | grep 'inet addr:'| grep -v '127.0.0.1' | cut -d: -f2 | sort | awk '{print $1}')

setsid /usr/local/etcd/etcd --listen-peer-urls 'http://10.211.57.101:2380,http://10.211.57.101:7001' --listen-client-urls 'http://10.211.57.101:2379,http://10.211.57.101:4001' --advertise-client-urls 'http://10.211.57.101:2379,http://10.211.57.101:4001' >"/tmp/etcd.log" 2>&1 &

setsid $KUBERNETES_HOME/server/bin/kube-apiserver \
--address=0.0.0.0 \
--port=8080 \
--kubelet_port=10250 \
--portal_net=10.0.0.0/24 \
--etcd_servers=http://10.211.57.101:4001 \
--logtostderr=true \
--v=0 \
--allow_privileged=false >"/tmp/kube-apiserver.log" 2>&1 &

echo "started kube-apiserver"

sleep 10

setsid $KUBERNETES_HOME/server/bin/kube-controller-manager \
--master=10.211.57.101:8080 \
--machines=10.211.57.101,10.211.57.102,10.211.57.103,10.211.57.104,10.211.57.105,10.211.57.106 \
--logtostderr=true \
--v=0 >"/tmp/kube-controller-manager.log" 2>&1 &

echo "started kube-controller-manager"

setsid $KUBERNETES_HOME/server/bin/kube-scheduler \
--master=10.211.57.101:8080 \
--logtostderr=true \
--v=0 >"/tmp/kube-scheduler.log" 2>&1 &

echo "started kube-scheduler"

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
