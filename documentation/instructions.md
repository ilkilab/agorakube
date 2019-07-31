# Prerequis

This section explain what are the prerequis to use Ilki-kube in your environement.

## OS

  - Ubuntu 18.04 (Bionic) - amd64

# Architecture


# Setup machines

This section explain how to setup machines before deploying Kubernetes Clusters with Ilki-Kube.

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

The "deploy" section contain information about how to connect to the deployment machine.

The "etcd" section contain information about the etcd machine(s) instances.

The "masters" section contain information about the masters nodes (K8S Control Plane).

The "workers" section contain information about the workers nodes (K8S Data Plane).

The "all:vars" section contain information about how to connect to K8S nodes.

