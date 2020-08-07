# Table of Contents
This is a list of points that will be explained in this instructions file for the [AgoraKube](https://agorakube.ilkilabs.io/) project :

- [High-level Architecture](#high-level-architecture)
- [Prerequisites](#prerequisites)
- [Nodes Setup](#nodes-setup)
- [K8S Cluster Configuration](#k8s-cluster-configuration)
- [Agorakube Parameters](#agorakube-parameters)
- [Kubernetes deployment](#kubernetes-deployment)
- [Manage ETCD Cluster](./manage_etcd.md)


# High-level Architecture

Below a diagram of the high-level architecture deployed by [AgoraKube](https://agorakube.ilkilabs.io/) :
![Architecture](../images/AgoraKube_diagram.png)

**Notes :** This distibution is aimed to be customizable so you can choose : 
 - Where the **etcd** will be deployed (with the master or not) 
 - The number of **master** nodes to deploy (from 1 to many)
 - The number of **etcd** nodes to deploy (from 1 to many)
 - The number of **worker** nodes to deploy (from 1 to many)
 
 # Prerequisites

This section explains what are the prerequisites to install [AgoraKube](https://agorakube.ilkilabs.io/) in your environment.

## OS

Below the OS currently supported on all the machines :
  - Ubuntu 18.04 & 20.04 - amd64
  - Centos 7 - amd64
  - Debian 10 - amd64
  
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

This section explains how to setup notes before deploying Kubernetes Clusters with [AgoraKube](https://agorakube.ilkilabs.io/).

## Deployment node

The deployment node is an Ansible server which contains all Ansible roles and variables used to deploy and configure Kubernetes Clusters with [AgoraKube](https://agorakube.ilkilabs.io/) distribution.

- Connect to the deployment node and run the following command :
```
bash <(curl -s https://raw.githubusercontent.com/ilkilab/agorakube-core/master/setup-deploy.sh)
```


## K8S nodes

The K8S nodes will host all the components needed for a Kubernetes cluster Control and Data planes.

The prerequisites are:
- SSH Server (like Openssh)
- Python2

You can run the following command to automatically install those packages :
```
bash <(curl -s https://raw.githubusercontent.com/ilkilab/agorakube-core/master/setup-hosts.sh)
```

## SSH keys creation

[Agorakube](https://agorakube.ilkilabs.io/) is using Ansible to deploy Kubernetes. You have to configure SSH keys to ensure the communication between the deploy machine and the others.

On the deploy machine, create the SSH keys :
```
ssh-keygen
```
You can let everything by default.

When your keys are created, you have to copy the public key in the other machine in the folder /home/yourUser/.ssh/authorized_keys, or you can use the following commands to copy the key :
```
ssh-copy-id -i .ssh/id_rsa.pub yourUser@IP_OF_THE_HOST
```
You have to execute this command for each node of your cluster

Once your ssh keys have been pushed to all nodes, modify the file "agorakube/hosts" to add the user/ssh-key (in section **SSH Connection settings**) that Agorakube will use to connect to all nodes

# K8S Cluster Configuration

[AgoraKube](https://agorakube.ilkilabs.io/) enables an easy way to deploy and manage customizable K8S clusters.

## Inventory file

The first file to modify is ["./hosts"](../hosts). This file contains all architecture information about your K8S Cluster.

**All K8S servers names must be filled in by their FQDN.**

The next Sample deploys K8S components in HA mode on 6 nodes (3 **etcd/masters** nodes, 3 **workers** nodes) :

```
[deploy]
master1 ansible_connection=local

[masters]
master1  ansible_host=10.10.20.3
master2  ansible_host=10.10.20.13
master3  ansible_host=10.10.20.23

[etcd]
master1  ansible_host=10.10.20.3
master2  ansible_host=10.10.20.13
master3  ansible_host=10.10.20.23

[workers]
worker1  ansible_host=10.10.20.4
worker2  ansible_host=10.10.20.5
worker3  ansible_host=10.10.20.6

[all:vars]
advertise_ip_masters=10.10.20.3

# SSH connection settings
ansible_ssh_extra_args='-o StrictHostKeyChecking=no'
ansible_user=vagrant
ansible_ssh_private_key_file=/home/vagrant/ssh-private-key.pem
```

The **deploy** section contains information about how to connect to the deployment machine.

The **etcd** section contains information about the etcd machine(s) instances.

The **masters** section contains information about the masters nodes (K8S Control Plane).

The **workers** section contains information about the workers nodes (K8S Data Plane).

The **all:vars** section contains information about how to connect to K8S nodes.

The **SSH Connection settings** section contain information about the SSH connexion. You have to modify the variable **ansible_ssh_private_key_file** with the path where your public key is stored.
**ansible_user** User used as service account by Agorakube to connect to all nodes. **User must be sudoer**.

## Configuration file

The [../group_vars/all.yaml](../group_vars/all.yaml) file contains all configuration variables that you can customize to make your K8S Cluster fit your needs.

Sample file will deploy **containerd** as container runtime, **flannel** as CNI plugin and **coredns** as DNS service : 

```
---
# PKI info
state_or_province_name: "Ile-De-France"
locality_name: "Paris"
country_name: "FR"
root_ca_common_name: "kubernetes"
expiry: "+3650d" # Default validity duration for PKI certificates.

# PKI management parameters
rotate_certificats: False # This parameter is used to renew K8S PKI certificats
rotate_token_certificats: False # This parameter renew Service Account Token certs.

# Components version
etcd_release: v3.4.9
kubernetes_release: v1.18.6
delete_previous_k8s_install: False
delete_etcd_install: False
check_etcd_install: True

# IPs-CIDR Configurations
cluster_cidr: 10.33.0.0/16
service_cluster_ip_range: 10.32.0.0/24
kubernetes_service: 10.32.0.1
cluster_dns_ip: 10.32.0.10
service_node_port_range: 30000-32000
cni_release: 0.8.6
enable_metallb_layer2: True # If set to true, install metlab LB on your K8S cluster. This enable Service type LoadBalancer
metallb_layer2_ips: 10.100.200.10-10.100.200.250 # Set Exeternal IP pool used by Service Type LoabBalancer "FistIP-LastIP"
# metallb_secret_key is generated with command : openssl rand -base64 128
metallb_secret_key: LGyt2l9XftOxEUIeFf2w0eCM7KjyQdkHform0gldYBKMORWkfQIsfXW0sQlo1VjJBB17shY5RtLg0klDNqNq4PAhNaub+olSka61LxV73KN2VaJY/snrZmHbdf/a7DfdzaeQ5pzP6D5O7zbUZwfb5ASOhNrG8aDMY3rkf4ZzHkc=

# Custom features
runtime: containerd
ingress_controller: nginx
populate_etc_hosts: True
k8s_dashboard: True
enable_metrics_server: True
enable_persistence: True
enable_monitoring: True
dashboard_admin_user: administrator
dashboard_admin_password: P@ssw0rd
# Security
encrypt_etcd_keys:
# Warrning: If multiple keys are defined ONLY LAST KEY is used for encrypt and decrypt.
# Other keys are used only for decrypt purpose. Keys can be generated with command: head -c 32 /dev/urandom | base64
  key1:
    secret: 1fJcKt6vBxMt+AkBanoaxFF2O6ytHIkETNgQWv4b/+Q=

# Data Directory
data_path: "/var/agorakube"
etcd_data_directory: "/var/lib/etcd"
#restoration_snapshot_file: /path/snopshot/file Located on {{ etcd_data_directory }}
```

**Note :** You can also modify the IPs-CIDR if you want.

# Agorakube Parameters

Below  you can find all the parameters you can use in this file, section by section.

### Certificates section

This section is used to custom certificates information.

| Parameter | Description | Values |
| --- | --- | --- |
| `root_ca_common_name` | Certificate authority name | <ul><li> **Depend on your deployment** </li><br/><li>  **ilkilabs** *(default)* </li></ul>|
| `country_name` | Country where the certificate is issued | <ul><li> **Depend on your deployment** </li><br/><li>  **FR** *(default)* </li></ul>|
| `state_or_province_name` | State where the certificate is issued | <ul><li> **Depend on your deployment** </li><br/><li>  **Ile-de-France** *(default)* </li></ul>|
| `locality_name` | City where the certificate is issued | <ul><li> **Depend on your deployment** </li><br/><li>  **Paris** *(default)* </li></ul>|
| `expiry` | Certificate lifetime in hours | <ul><li> **Depend on your needs** </li><br/><li>  **87600h** *(default)* </li></ul>|
| `rotate_certificats` | Rotate certificates for your cluster | <ul><li> **false** *(default)* </li><br/><li>  **true** </li></ul>|
### Components version section

This section is used to custom the components version of your deployment.

| Parameter | Description | Values |
| --- | --- | --- |
| `etcd_release` | Version of etcd component | <ul><li> **3.3.X** or **3.4.X** </li><br/><li>  **v3.4.10** *(default)* </li></ul>|
| `kubernetes_release` | Version of kubernetes components | <ul><li> **1.15.X**, **1.16.X**, **1.17.X** or **1.18.X** </li><br/><li>  **1.18.6** *(default)* </li></ul>|
| `delete_previous_k8s_install` | Deletion of previous installations of Kubernetes | <ul><li> **true** </li><br/><li>  **false** *(default)* </li></ul>|
| `delete_etcd_install` | Deletion of previous installations of ETCD | <ul><li> **true** </li><br/><li>  **false** *(default)* </li></ul>|
| `check_etcd_install` | Print ETCD Status | <ul><li> **true** </li><br/><li>  **false** *(default)* </li></ul>|

### IPs-CIDR Configurations

This section is used to custom network configurations of your deployment.

**Note :** It will depend on the CNI plugin used.

| Parameter | Description | Values |
| --- | --- | --- |
| `cluster_cidr` | CIDR used for all pods deployed in your cluster | <ul><li> **Depend on your deployment** </li><br/><li>  **10.33.0.0/16** *(default)* </li></ul>|
| `service_cluster_ip_range` | CIDR used for all services deployed in your cluster | <ul><li> **Depend on your deployment** </li><br/><li>   **10.32.0.0/16** *(default)* </li></ul>|
| `kubernetes_service` | IP used for Kubernetes service of your cluster. **Must be** the first IP of your service CIDR ! | <ul><li> **Depend on your deployment** </li><br/><li>  **10.32.0.1** *(default)* </li></ul>|
| `cluster_dns_ip` | IP used for DNS services deployed in your cluster | <ul><li> **Depend on your deployment** </li><br/><li>  **10.32.0.10** *(default)* </li></ul>|
| `service_node_port_range` | Range of ports used for all NodePort services deployed in your cluster | <ul><li> **depend on your deployment** </li><br/><li>   **30000-32767** *(default)* </li></ul>|
| `cni_release` | CNI release to use | <ul><li>  **0.8.6** *(default)* </li></ul>|
| `enable_metallb_layer2` | Enable MetalLB. This add Service type LoadBalancer support to Kubernetes | <ul><li> **Depend on your deployment** </li><br/><li>  **True** *(default)* </li></ul>|
| `metallb_layer2_ips` | IP range used by LoadBalancer Service  | <ul><li> **Depend on your deployment** </li><br/><li>  **10.100.200.10-10.100.200.250** *(default)* </li></ul>|
| `metallb_secret_key` | metallb_secret_key is generated with command : openssl rand -base64 128 | <ul><li> **Depend on your deployment** </li></ul>|

### Custom features section

This section is used to defined all custom features of your deployment.

| Parameter | Description | Values |
| --- | --- | --- |
| `runtime` | Container runtime used in your deployment | <ul><li> **containerd** *(default)* </li><br/><li>  **docker**  </li></ul>|
| `network_cni_plugin` | CNI plugin used in your deployment | <ul><li> **calico** </li><br/><li>  **kube-router** *(default)* </li></ul>|
| `ingress_controller` | Ingress Controller used in your deployment | <ul><li> **traefik** *(default)* </li><br/><li>  **ha-proxy**  </li><br/><li>  **nginx**  </li><br/><li>  **none**  </li></ul>|
| `populate_etc_hosts` | Populate */etc/hosts* file of all your nodes in the cluster | <ul><li> **no** </li><br/><li>  **yes** *(default)* </li></ul>|
| `k8s_dashboard` | Deploy Kubernetes dashboard in your cluster | <ul><li> **false** </li><br/><li>  **true** *(default)* </li></ul>|


### Other parameters sections

Parameters for etcd :

| Parameter | Description | Values |
| --- | --- | --- |
| `encrypt_etcd_keys` | Encryption keys used for etcd - Dictionary format | <ul><li> **Depend on your deployment** </li><br/><li>  **1fJcKt6vBxMt+AkBanoaxFF2O6ytHIkETNgQWv4b/+Q=** *(default)* </li></ul> |
| `check_etcd_install` | Display ETCD infos | <ul><li> **True** (Default) </li><br/><li>  False </li></ul> |

Parameters for Agorakube datas storage :

| Parameter | Description | Values |
| --- | --- | --- |
| `data_path` | Path to Agorakube datas directory | <ul><li> **Depend on your deployment** </li><br/><li> **"/var/agorakube"** *(default)* </li></ul> |

Parameters for etcd data location, and backups

| Parameter | Description | Values |
| --- | --- | --- |
| `etcd_data_directory` | Directory to store etcd data on **etcd members** | <ul><li> **/var/lib/etcd/** (default) </li><br/></ul> |
| `custom_etcd_backup_dir` | Directory where etcd leader backups are stored on **deploy** node | <ul><li> **{{data_path}}/backups_etcd/** (default if not defined) </li><br/></ul> |
| `restoration_snapshot_file` | Path to the etcd snapshot on **deploy** node | <ul><li> **not defined** (default) </li><br/></ul> |


Monitoring Settings

| Parameter | Description | Values |
| --- | --- | --- |
| `enable_monitoring` | Deploy monitoring - Warrning : **Rook Must be enabled !** | <ul><li> **False** (default) </li><br/><li>  **true** </li></ul> |

# Kubernetes deployment

Once all configuration files are set, run the following command to launch the Ansible playbook that will deploy the pre-configured Kubernetes cluster :

```
sudo ansible-playbook agorakube.yaml
```
