# vagrant-kubernetes
vagrant scripts for kubernetes

setsid /usr/bin/etcd >"/tmp/etcd.log" 2>&1 &

setsid $KUBERNETES_HOME/server/bin/kube-apiserver \
  -address=0.0.0.0 \
  -port=8080 \
  -kubelet_port=10250 \
  -portal_net=10.0.0.0/24 \
  -etcd_servers=http://10.211.57.101:4001 \
  -logtostderr=true \
  -v=0 \
  -allow_privileged=false >"/tmp/kube-apiserver.log" 2>&1 &

echo "start kube-apiserver"

sleep 10

setsid $KUBERNETES_HOME/server/bin/kube-controller-manager \
  -master=10.211.57.101:8080 \
  -machines=10.211.57.101,10.211.57.102,10.211.57.103,10.211.57.104 \
  -logtostderr=true \
  -v=0 >"/tmp/kube-controller-manager.log" 2>&1 &

echo "start kube-controller-manager"

setsid $KUBERNETES_HOME/server/bin/kube-scheduler \
  -master=10.211.57.101:8080 \
  -logtostderr=true \
  -v=0 >"/tmp/kube-scheduler.log" 2>&1 &

echo "start kube-scheduler"

setsid $KUBERNETES_HOME/server/bin/kubelet \
  -address=10.211.57.101 \
  -port=10250 \
  -hostname_override=10.211.57.101 \
  -etcd_servers=http://10.211.57.101:4001 \
  -logtostderr=true \
  -v=0 \
  -allow_privileged=false >"/tmp/kubelet.log" 2>&1 &

echo "start kubelet"

setsid $KUBERNETES_HOME/server/bin/kube-proxy \
  -v=0 \
  -master="http://10.211.57.101:4001" >"/tmp/kube-proxy.log" 2>&1 &

