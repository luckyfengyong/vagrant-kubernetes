vagrant-kubernetes-v0.9.1
================================

# Introduction

Vagrant project to spin up a cluster of 6 virtual machines with etcd v2.0.0, kubernetes v0.9.1.

1. k8snode1 : etcd + kubernetes controller node
2. k8snode2 : kubernetes minions
3. k8snode3 : kubernetes minions
4. k8snode4 : kubernetes minions
5. k8snode5 : kubernetes minions
6. k8snode6 : kubernetes minions

# Getting Started

1. [Download and install VirtualBox](https://www.virtualbox.org/wiki/Downloads)
2. [Download and install Vagrant](http://www.vagrantup.com/downloads.html).
3. Run ```vagrant box add centos65 https://github.com/2creatives/vagrant-centos/releases/download/v6.5.3/centos65-x86_64-20140116.box```
4. Git clone this project, and change directory (cd) into this project (directory).
5. Run ```vagrant up``` to create the VM.
6. Run ```vagrant ssh``` to get into your VM. The VM name in vagrant is k8snode1, k8snode2 ... k8snoden. While the ip of VMs depends on the scale of your kubernetes cluster. If it is less then 10, the IP will be 10.211.55.101, .... 10.211.55.10n. Or you could run ```ssh``` directly with ip of VMs and username/password of root/vagrant.
7. Run ```vagrant destroy``` when you want to destroy and get rid of the VM.
8. The directory of /vagrant is mounted in each VM by vagrant if you want to access host machine from VM. You could also use win-sshfs if you want to access the local file system of VM from host machine. Please refer to http://code.google.com/p/win-sshfs/ for details.

Some gotcha's.

* Make sure you download Vagrant v1.7.1 or higher and VirtualBox 4.3.20 or higher with extension package
* Make sure when you clone this project, you preserve the Unix/OSX end-of-line (EOL) characters. The scripts will fail with Windows EOL characters. If you are using Windows, please make sure the following configuration is configured in your .gitconfig file which is located in your home directory ("C:\Users\yourname" in Win7 and after, and "C:\Documents and Settings\yourname" in WinXP). Refer to http://git-scm.com/book/en/v2/Customizing-Git-Git-Configuration for details of git configuration.
```
[core]
    autocrlf = false
    safecrlf = true
```
* Make sure you have 10Gb of free memory for the VMs. You may change the Vagrantfile to specify smaller memory requirements.
* This project has NOT been tested with the other providers such as VMware for Vagrant.
* You may change the script (common.sh) to point to a different location for etcd, kubernetes to be downloaded from.

# Advanced Stuff

If you have the resources (CPU + Disk Space + Memory), you may modify Vagrantfile to have even more kubernetes minions. Just find the line that says "numNodes = 6" in Vagrantfile and increase that number. The scripts should dynamically provision the additional slaves for you.

# Make the VMs setup faster
You can make the VM setup even faster if you pre-download the etcd and kubernetes into the /resources directory.

* /resources/etcd-v2.0.0-linux-amd64.tar.gz
* /resources/kubernetes.tar.gz

The setup script will automatically detect if these files (with precisely the same names) exist and use them instead. If you are using slightly different versions, you will have to modify the script accordingly.

# Start Kubernetes Cluster
After you have provisioned the cluster, SSH into kubesnode1 and run the following command.

```
startk8s.sh
```

And then, SSH into other nodes and run the following command.

```
startk8sslave.sh
```

# Test etcd
Run the following command to make sure etcd works

```
etcdctl --peers 10.211.57.101:4001 set key1 value1
```

Refer to https://github.com/coreos/etcd/blob/master/Documentation/admin_guide.md for more info of etcd

# Test kubernetes
Run the following command to make sure kubernetes works

```
kubectl get minions
```

Refer to https://github.com/GoogleCloudPlatform/kubernetes/blob/master/examples/walkthrough/README.md for more info of kubernetes

Refer to http://weaveblog.com/2014/11/11/weave-for-kubernetes/ for how to configure weave for kubernetes
