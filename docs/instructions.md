# High-level Architecture

Below a diagram of the high-level architecture deployed by AgoraKube :
![Architecture](./images/AgoraKube_diagram.png)

**Notes :** This distibution is aimed to be customizable so you can choose : 
 - Where the **etcd** will be deployed (with the master or not) 
 - The number of **master** nodes to deploy (from 1 to many)
 - The number of **etcd** nodes to deploy (from 1 to many)
 - The number of **worker** nodes to deploy (from 1 to many)
 
 # Prerequisites

This section explains what are the prerequisites to install AgoraKube in your environment.

## OS

Below the OS currently supported on all the machines :
  - Ubuntu 18.04 (Bionic) - amd64
  
## Node Sizing

Below the sizing prerequisites for all the nodes (master and worker) :
- 2 GB or more of RAM per machine
- 2 CPUs or more
- Full network connectivity between all machines in the cluster (public or private network is fine)
- Full internet access
- Unique hostname, MAC address, and product_uuid for every node. See here for more [details](https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/#verify-the-mac-address-and-product-uuid-are-unique-for-every-node).
- Certain ports are open on your machines. See here for more [details](https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/#check-required-ports).
- Swap disabled. You MUST disable swap in order for the kubelet to work properly.

Below the sizing prerequisites for the deployment machine :
- 2 GB or more of RAM
- 1 CPU or more
- Full network connectivity between all machines in the cluster (public or private network is fine)
- Full internet access

# Nodes Setup

This section explains how to setup notes before deploying Kubernetes Clusters with AgoraKube.

## Deployment node

The deployment node is an Ansible server which contains all Ansible roles and variables used to deploy and configure Kubernetes Clusters with AgoraKube distribution.

- Connect to the deployment node and run the following command :
```
bash <(curl -s https://raw.githubusercontent.com/ilkilab/agorakube/master/install.sh)
```

**Important note** : The deployment machine **MUST** be able to resolve all K8S nodes hostnames (Use a DNS server or edit **/etc/hosts** file).

## K8S nodes

The K8S nodes will host all the components needed for a Kubernetes cluster Control and Data planes.

The prerequisites are:
- SSH Server (like Openssh)
- Python2

You can run the following command to automatically install those packages :
```
sudo apt update && sudo apt install -yqq openssh-server python
```

# K8S Cluster Configuration

AgoraKube enables an easy way to deploy and manage customizable K8S clusters.

## Inventory file

The first file to modify is ["./hosts"](./hosts). This file contains all architecture information about your K8S Cluster.

The next Sample deploys K8S components in HA mode on 6 nodes (3 **etcd/masters** nodes and 3 **workers** nodes) :

```
[deploy]
deploy ansible_connection=local

[masters]
etcd-1 ip=10.20.20.5
etcd-2 ip=10.20.20.4
etcd-3 ip=10.20.20.6

[etcd]
etcd-1  ip=10.20.20.5
etcd-2  ip=10.20.20.4
etcd-3  ip=10.20.20.6

[workers]
worker-1  ip=10.20.20.7
worker-2  ip=10.20.20.9
worker-3  ip=10.20.20.10


[all:vars]
ansible_ssh_extra_args='-o StrictHostKeyChecking=no'
ansible_user=cloud
ansible_ssh_private_key_file=/etc/ansible_keys/private.pem
```

The **deploy** section contains information about how to connect to the deployment machine.

The **etcd** section contains information about the etcd machine(s) instances.

The **masters** section contains information about the masters nodes (K8S Control Plane).

The **workers** section contains information about the workers nodes (K8S Data Plane).

The **all:vars** section contains information about how to connect to K8S nodes.


## Configuration file

This [file](./group_vars/all.yaml) contains all configuration variables that you can customize to make your K8S Cluster fit your needs.

Sample file will deploy **containerd** as container runtime, **flannel** as CNI plugin and **coredns** as DNS service : 

```
---

# CERTIFICATES
cn_root_ca: ilkilabs
c: FR
st: Ile-De-France
l: Paris
expiry: 87600h


# IPs-CIDR Configurations
 
advertise_ip_masters: 10.20.20.5
cluster_cidr: 10.244.0.0/16
service_cluster_ip_range: 10.32.0.0/24
kubernetes_service: 10.32.0.1
cluster_dns_ip: 10.32.0.10

# Custom features

runtime: containerd   # supported values: containerd, docker
network_cni_plugin: flannel
ingress_controller: traefik
dns_server_soft: coredns
label_workers: true
populate_etc_hosts: yes

# Security

encrypt_key_etcd: 1fJcKt6vBxMt+AkBanoaxFF2O6ytHIkETNgQWv4b/+Q=
```

**Note :** You can also modify the IPs-CIDR if you want.

## Kubernetes deployment

Once all configuration files are set, run the following command to launch the Ansible playbook that will deploy the pre-configured Kubernetes cluster :

```
sudo ansible-playbook agorakube.yaml
```
