# Prerequis

This section explains what are the prerequis to use Ilki-kube in your environement.

## OS

  - Ubuntu 18.04 (Bionic) - amd64

# Architecture


# Setup machines

This section explains how to setup machines before deploying Kubernetes Clusters with Ilki-Kube.

## Deployment machine

The deployment machine is an Ansible server wich contain all Ansible roles and variables used to deploy and configure Kubernetes Clusters with Ilki-Kube distribution.

- Connect to the deployment machine and run the following command :
```
bash <(curl -s https://raw.githubusercontent.com/pierreilki/IlkiKube/master/install.sh)
```

The deployment machine MUST be able to resolve hostname of  K8S machines. (Use DNS or edit /etc/hosts)

## K8S machines

The K8S machines are the node for the Control and Data planes of Kubernetes Clusters.

The prerequis are:
- SSH Server (like Openssh)
- python2

You can run the following command to setup automatically prerequis:
```
sudo apt update && sudo apt install -yqq openssh-server python
```

# Configuration K8S Cluster

Ilki-Kube enable an easy way to deploy and manage K8S clusters automatically.

## Inventory file : ./hosts

The first file to modify is **"./hosts"**. This file contain all architecture information about your K8S Cluster.

The next Sample deploy K8S components in HA mode on 6 machines (3 etcd/masters and 3 workers) :

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

The "deploy" section contains information about how to connect to the deployment machine.

The "etcd" section contains information about the etcd machine(s) instances.

The "masters" section contains information about the masters nodes (K8S Control Plane).

The "workers" section contains information about the workers nodes (K8S Data Plane).

The "all:vars" section contains information about how to connect to K8S nodes.


## Configuration file : ./group_vars/all.yaml


This file contains all configuration variables that you can  customine to make your K8S Cluster fit your needs.

Sample file : 

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

runtime: containerd
network_cni_plugin: flannel
ingress_controller: traefik
dns_server_soft: coredns
label_workers: true
populate_etc_hosts: yes

# Security

encrypt_key_etcd: 1fJcKt6vBxMt+AkBanoaxFF2O6ytHIkETNgQWv4b/+Q=
```

## Deploy K8S

Once all configuration files are set, just run the following command :

```
ansible-playbook ilkikube.yaml
```
