# Table of Contents
This is a list of points that will be explained in this instructions file for the AGORAKUBE project :

- [High-level Architecture](#high-level-architecture)
- [Prerequisites](#prerequisites)
- [Nodes Setup](#nodes-setup)
- [K8S Cluster Configuration](#k8s-cluster-configuration)
- [AGORAKUBE Parameters](#agorakube-parameters)
- [Kubernetes deployment](#kubernetes-deployment)
- [Manage ETCD Cluster](./manage_etcd.md)
- [Create Pod](#create-pod)
- [How to use Ingress-Nginx](#how-to-use-ingress-nginx)
- [AGORAKUBE Log Architecture](#agorakube-log-architecture)
- [Configure Calico](#configure-calico)
- [Upgrade And Downgrade Kubernetes with Agorakube](#upgrade-and-downgrade-kubernetes-with-Agorakube)
- [Uninstall AGORAKUBE](#uninstall-agorakube)


# High-level Architecture

Below is a diagram of the high-level architecture deployed by AGORAKUBE :
![Architecture](../images/AGORAKUBE_diagram.png)

**Notes :** This distribution is aimed to be customizable so you can choose : 
 - Where the **etcd** will be deployed (with the master or not) 
 - The number of **master** nodes to deploy (from 1 to many - 5 nodes for production)
 - The number of **etcd** nodes to deploy (from 1 to many - 5 nodes for production)
 - The number of **worker** nodes to deploy (from 1 to many)
 
 # Prerequisites

This section details the prerequisites to install AGORAKUBE in your environment.

## OS

Below are the OS's currently supported on all the machines:
  - Ubuntu 18.04 & 20.04 - amd64
  - Debian 10 - amd64

## Network

- Full network connectivity between all machines in the cluster (public or private network is fine)
- Full internet access
- Unique hostname, MAC address, and product_uuid for every node. See here for more [details](https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/#verify-the-mac-address-and-product-uuid-are-unique-for-every-node).
- Certain ports are open on your machines. See here for more [details](https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/#check-required-ports).

If Agorakube is installed behind a Proxy/Firewall, make sure the following URLs are accessible:
-	https://pypi.org/
-	https://pypi.python.org/
-	https://files.pythonhosted.org
-	https://storage.googleapis.com/kubernetes-release/
-	https://github.com/etcd-io/etcd/releases/download/
-	https://dl.k8s.io/
-	https://github.com/containernetworking/plugins/releases/download/
-	https://download.docker.com/linux/
-	https://index.docker.io/v1/
-	https://k8s.gcr.io/
-	https://docker.io
-	https://github-releases.githubusercontent.com/


## Node Sizing

Node sizing indicated here is for a production environment. You can custom it accordingly to suit your needs.

It is best-practice to install ETCD and MASTERS on separate hosts.

| AGORAKUBE Type | no HA or all-in-one | no-production | production |
| --- | --- | --- | --- |
| MASTER | 1 | 2 | 3+ |
| ETCD | 1 | 3 | 5 |
| WORKER | 1 | X | X |
| STORAGE | 0 - 1 | 3 | 3+ |

We actually configure the proper VM size for your MASTER depending on the number of nodes (Workers + Storage) in your cluster

| nodes | Master Size |
| --- | --- |
| 1-5 | 1 CPU - 3,75 Go RAM |
| 6-10 | 2 CPU - 7,50 Go RAM |
| 11-100 | 4 CPU - 15 Go RAM |
| 101-250 | 8 CPU - 30 Go RAM |
| 251-500 | 16 CPU - 60 Go RAM |
| more than 500 | 32 CPU - 120 Go RAM |

We actually configure the proper VM size for your ETCD depending on the number of nodes (Workers + Storage + Masters) in your cluster

| nodes | ETCD Size | Notes |
| --- | --- | --- |
| 0-50 | 2 CPU - 8 Go RAM | A small cluster serves fewer than 100 clients, fewer than 200 of requests per second, and stores no more than 100MB of data |
| 50-250 | 4 CPU - 16 Go RAM | A medium cluster serves fewer than 500 clients, fewer than 1,000 of requests per second, and stores no more than 500MB of data |
| 250-1000 | 8 CPU - 32 Go RAM | A large cluster serves fewer than 1,500 clients, fewer than 10,000 of requests per second, and stores no more than 1GB of data |
| 1000-3000 | 16 CPU - 64 Go RAM | An xLarge cluster serves more than 1,500 clients, more than 10,000 of requests per second, and stores more than 1GB data |


These CPU and memory requirements apply to each Worker in a Agorakube

| Worker Size     | vCPUs  | RAM      |
| --------------- | -------| ---------|
| nano            | 1      | 3 GB     |
| Small           | 2      | 8 GB     |
| Medium          | 4      | 16 GB    |
| Large           | 8      | 32 GB    |
| X-Large         | 16     | 64 GB    |
| XX-Large        | 32     | 128 GB   |

Every use case and environment is different, adapt to your needs.

# Nodes Setup

This section explains how to set up nodes before deploying Kubernetes Clusters with AGORAKUBE.

## Deployment node

The deployment node is an Ansible server which contains all Ansible roles and variables used to deploy and configure Kubernetes Clusters with AGORAKUBE distribution.

The prerequisites are:
- SSH Server (like openssh-server)
- Python3 & pip3
- git
- curl
- with pip3 : ansible, netaddr

Then clone or download the AGORAKUBE git branch / release you want to use.

You can run the following command to automatically install those packages and clone the latest stable AGORAKUBE distribution:
```
bash <(curl -s https://raw.githubusercontent.com/ilkilab/agorakube/master/setup-deploy.sh)
```

### Use Python Virtual Environment

Sometimes it is better to run Ansible and all its dependences in a specific *Python Virtual Environment*. This will make it easier for you to install Ansible and all its dependences needed by AGORAKUBE without the risk of breaking your existing Python/Python3 installation.


You can create your own *Python Virtual Environment* from scratch by following:

```
# Install on deploy machine python3, pyhton3-pip and python3-venv
# On Ubuntu (18.04) or Debian10 use the following commands:
apt update
apt install -yqq python3 python3-pip python3-venv

# Install on deploy machine python3, pyhton3-pip and python3-venv
# On Ubuntu (20.04) or Debian10 use the following commands:
apt update
apt install python3.8-venv

# Create a Python Virtual Environment
python3 -m venv /usr/local/agorakube-env

# Tell to your shell to use this Python Virtual Environment
source /usr/local/agorakube-env/bin/activate

# Update PIP
pip3 install --upgrade pip

# Then install Ansible and Netaddr (needed by AGORAKUBE)
pip3 install ansible
pip3 install netaddr
pip3 install selinux

# You can alternatively install packages with "agorakube/requirements.txt" file located on AGORAKUBE
pip3 install -r agorakube/requirements.txt

# Validate ansible is installed and use your Python Virtual Environment
ansible --version

#ansible 2.10.5
#  config file = None
#  configured module search path = ['/root/.ansible/plugins/modules', '/usr/share/ansible/plugins/modules']
#  ansible python module location = /usr/local/agorakube-env/lib/python3.8/site-packages/ansible
#  executable location = /usr/local/agorakube-env/bin/ansible
#  python version = 3.8.5 (default, Jul 28 2020, 12:59:40) [GCC 9.3.0]


# If you want to stop using the Python Virtual Environment, just execute the following command:
deactivate
```


## K8S nodes

The K8S nodes will host all the components needed for a Kubernetes cluster Control and Data planes.

The prerequisites are:
- SSH Server (lagorakube openssh-server)
- Python3
- curl

You can run the following command to automatically install those packages :
```
bash <(curl -s https://raw.githubusercontent.com/ilkilab/agorakube/master/setup-hosts.sh)
```

## SSH keys creation

AGORAKUBE is using Ansible to deploy Kubernetes. You have to configure SSH keys to ensure the communication between the deploy machine and the others.

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

Once your ssh keys have been pushed to all nodes, modify the file "agorakube/hosts" to add the user/ssh-key (in section **SSH Connection settings**) that AGORAKUBE will use to connect to all nodes

# K8S Cluster Configuration

AGORAKUBE enables an easy way to deploy and manage customizable K8S clusters.

## ansible.cfg file

This file allows you to configure default settings for your Ansible server.

**If you are using CentOS-7, make sure to set "interpreter_python = /usr/bin/python2.7" !!** Ansible on CentOS-7 doesn't fully support Python3. 



## Inventory file

The first file to modify is ["./hosts"](../hosts). This file contains all architecture information about your K8S Cluster.

**All K8S servers names must be filled in by their FQDN**. You can run ```hostname -f``` on your hosts to get it.

The next Sample deploys K8S components in HA mode on 6 nodes (3 **etcd/masters** nodes, 3 **workers** nodes) :

```
[deploy]
deploy ansible_connection=local ansible_python_interpreter=/usr/bin/python3

[masters]
master1  ansible_host=10.10.20.4

[etcd]
master1  ansible_host=10.10.20.4

[workers]
worker2  ansible_host=10.10.20.5
worker3  ansible_host=10.10.20.6

[all:vars]
advertise_masters=10.10.20.4
#advertise_masters=kubernetes.localcluster.lan

# SSH connection settings
ansible_ssh_extra_args=-o StrictHostKeyChecking=no
ansible_user=vagrant
ansible_ssh_private_key_file=/home/vagrant/ssh-private-key.pem

# Python version

# If centOS-7, use python2.7
# If no-CentOS-7, like ubuntu (18.04, 20.04) or If Debian 10, use Python3
ansible_python_interpreter=/usr/bin/python3


[etc_hosts]
#kubernetes.localcluster.lan ansible_host=10.10.20.4
```

The **deploy** section contains information about how to connect to the deployment machine.

The **etcd** section contains information about the etcd machine(s) instances.

The **masters** section contains information about the masters nodes (K8S Control Plane).

The **workers** section contains information about the workers nodes (K8S Data Plane).

The **etc_hosts** section contains a list of DNS entries that will be injected to /etc/hosts files of all hosts. Use it only if you don't have DNS server.

The **all:vars** section contains information about how to connect to K8S nodes.

The **advertise_masters** parameter configure the Advertising IP of control Plane. Actually it is the IP of a frontal LB that expose Master nodes on port TCP/6443. It can also be a Master's IP if you don't have LB. In this case, HA is not enabled even if you got multiple Masters...

The **SSH Connection settings** section contain information about the SSH connexion. You have to modify the variable **ansible_ssh_private_key_file** with the path where your public key is stored.
**ansible_user** User used as service account by AGORAKUBE to connect to all nodes. **User must be sudoer**.

## Configuration file

The [./group_vars/all.yaml](../group_vars/all.yaml) file contains all configuration variables that you can customize to make your K8S Cluster fit your needs.

Sample file will deploy **containerd** as container runtime, **calico** as CNI plugin and enable all AGORAKUBE features (storage, dashboard, monitoring, LB, ingress, ....).

```
---
agorakube:
  global:
    data_path: /var/agorakube
agorakube_pki:
  infos:
    state: "Ile-De-France"
    locality: "Paris"
    country: "FR"
    root_cn: "ILKI Kubernetes Engine"
    expirity: "+3650d"
  management:
    rotate_certificats: False
agorakube_base_components:
  etcd:
    release: v3.4.21
    upgrade: False
    check: true
    data_path: /var/lib/etcd
  kubernetes:
    release: v1.25.2
    upgrade: False
  cloud_controller_manager:
    enabled: False
agorakube_network:
  cni_plugin: calico
  calico_autodetection_method: "first-found"
  mtu: 0
  cidr:
    pod: 10.33.0.0/16
    service: 10.32.0.0/16
  service_ip:
    kubernetes: 10.32.0.1 
    coredns: 10.32.0.10
  dns:
    primary_forwarder: 8.8.8.8
    secondary_forwarder: 8.8.4.4
  nodeport:
    range: 30000-32000
  external_loadbalancing:
    enabled: True
    ip_range: 10.201.20.50-10.201.20.250
  kube_proxy:
    mode: ipvs
    algorithm: rr
agorakube_features:
  coredns:
    release: "1.9.4"
    replicas: 2
  dashboard:
    enabled: True
    generate_admin_token: True
    release: v2.7.0
  metrics_server:
    enabled: True
  ingress:
    controller: nginx
    release: v1.3.1
etc_hosts:
  - hostname: "localhost"
    ip: "127.0.0.1"
# Populate /etc/hosts using all inventory groups
# Note: This will not remove /etc/hosts entries when removed from inventory
agorakube_populate_etc_hosts: True
# Remove ALL /etc/hosts entries that are NOT defined in the etc_hosts group or etc_hosts variable
agorakube_remove_etc_hosts: False
# Optionally backup /etc/hosts each time a change is made
agorakube_backup_etc_hosts: False
# Security
agorakube_encrypt_etcd_keys:
# Warrning: If multiple keys are defined ONLY LAST KEY is used for encrypt and decrypt.
# Other keys are used only for decrypt purpose. Keys can be generated with command: head -c 32 /dev/urandom | base64
  key1:
    secret: 1fJcKt6vBxMt+AkBanoaxFF2O6ytHIkETNgQWv4b/+Q=
agorakube_sonobuoy_mode: False
#restoration_snapshot_file: /path/snopshot/file Located on {{ etcd_data_directory }}

```

**Note :** You can also modify the IPs-CIDR if you want.

# AGORAKUBE Parameters

Below, you can find all the parameters you can use in this file, section by section.

## Global Section

This section is used to custom global AGORAKUBE settings.

| Parameter | Description | Values |
| --- | --- | --- |
| `agorakube.global.data_path` | Path where AGORAKUBE saves all config/pki/service files on deploy machine | **/var/agorakube/** *(default)* |

## Certificates & PKI section

This section is used to custom the PKI used for your deployment and manage Certificates lifecycle.

| Parameter | Description | Values |
| --- | --- | --- |
| `agorakube_pki.infos.state` | State or province name added to PKI CSR | **Ile-De-France** *(default)* |
| `agorakube_pki.infos.locality` | Locality added to PKI CSR | **Paris** *(default)* |
| `agorakube_pki.infos.country` | Country added to PKI CSR | **FR** *(default)* |
| `agorakube_pki.infos.root_cn` | CommonName used for Root CA | **ILKI Kubernetes Engine** *(default)* |
| `agorakube_pki.infos.expirity` | Expirity for all PKI certificats | **+3650d** (default - 10 years)|
| `agorakube_pki.management.rotate_certificats` | Boolean used to rotate certificates | **False** (default)|

## Main K8S Components Section

This section is used to custom K8S main components that will be deployed.

### ETCD

This section allows you to configure your ETCD deployment.

| Parameter | Description | Values |
| --- | --- | --- |
| `agorakube_base_components.etcd.release` | ETCD release that will be installed on etcd hosts | **v3.4.14** *(default)* |
| `agorakube_base_components.etcd.upgrade` | Upgrade current ETCD release to `agorakube_base_components.etcd.release` | **False** *(default)* |
| `agorakube_base_components.etcd.check` | Check ETCD cluster Status/Size/Health/Leader when running agorakube run | **True** *(default)* |
| `agorakube_base_components.etcd.data_path` | Path where ETCD save data on ETCD hosts | **/var/lib/etcd** *(default)* |


### Kubernetes

This section allows you to configure your Kubernetes deployment.

| Parameter | Description | Values |
| --- | --- | --- |
| `agorakube_base_components.kubernetes.release` | Kubernetes release that will be installed on *Master/Worker/Storage* hosts |  **v1.21.0** *(default)* |
| `agorakube_base_components.kubernetes.upgrade` | Upgrade current Kubernetes release to `agorakube_base_components.kubernetes.release` | **False** *(default)* |

### Cloud Controller Manager

This section allows you to configure the kubelet to use the [Cloud Controller Manager](https://kubernetes.io/docs/concepts/architecture/cloud-controller)

| Parameter | Description | Values |
| --- | --- | --- |
| `agorakube_base_components.cloud_controller_manager.enabled` | Enable or disable the `cloud-controller-manager` | **False** *(default)* |

### Container Engine

This section allows you to configure your Container Engine that will be deployed on all Master/Worker/Storage hosts.

| Parameter | Description | Values |
| --- | --- | --- |
| `agorakube_base_components.container.engine`  | Container Engine to install (Containerd or Docker) on all Master/Worker/Storage hosts |  **containerd** |
| `agorakube_base_components.container.release` | Release of Container Engine to install - Not supported wet  | If **""** install latest release *(default)* |
| `agorakube_base_components.container.upgrade` | Upgrade current Container Engine release to `agorakube_base_components.container.release` | **Will be available soon** (No effect) |

## Network Settings

This section allows you to configure your K8S cluster network settings.

| Parameter | Description | Values |
| --- | --- | --- |
| `agorakube_network.cni_plugin` | CNI plugin used to enable K8S hosts Networking | **calico** |
| `agorakube_network.calico_autodetection_method` | [Calico Autodetect Method](#configure-calico). Used by Calico to detect which IPv4 IFACE will be used to route between nodes  | **first-found** *(default)* |
| `agorakube_network.mtu` | MTU for CNI plugin. Auto-MTU if set to **0**. Only used if `agorakube_network.cni_plugin` is set to **calico** | **0** *(default)* |
| `agorakube_network.cidr.pod` | PODs CIDR network | **10.33.0.0/16** *(default)* |
| `agorakube_network.cidr.service` | Service CIDR network | **10.32.0.0/16** *(default)* |
| `agorakube_network.service_ip.kubernetes` | ClusterIP of *default.kubernetes* service. Should be the first IP available in `agorakube_network.cidr.service` | **10.32.0.1** *(default)* |
| `agorakube_network.service_ip.coredns` | ClusterIP of *kube-system.kube-dns* service. | **10.32.0.10** *(default)* |
| `agorakube_network.dns.primary_forwarder` | Default Primary DNS Forwarder | **8.8.8.8** *(default google DNS1)* |
| `agorakube_network.dns.secondary_forwarder` | Default Secondary DNS Forwarder | **8.8.4.4** *(default google DNS2)* |
| `agorakube_network.nodeport.range` | Range of allowed ports usable by NodePort services | **30000-32000** *(default)* |
| `agorakube_network.external_loadbalancing.enabled` | Enable External LoadBalancing in ARP mode. Working only if On-Prem deployments | **False** *(default)* |
| `agorakube_network.external_loadbalancing.ip_range` | IPs Range, or CIDR used by External LoadBalancer to assign External IPs  | **10.10.20.50-10.10.20.250** *(default range)* |
| `agorakube_network.kube_proxy.mode` | Kube-Proxy mode. iptables/ipvs. IPVS > IPTABLES | **ipvs** *(default)* |
| `agorakube_network.kube_proxy.algorithm` | Default ClusterIP loadBalancing Algorithm : rr,lc,dh,sh,sed,nq. Only supported if IPVS | **rr** *(default Round-Robin)* |


## AGORAKUBE features

This section allows you to configure your K8S features.

| Parameter | Description | Values |
| --- | --- | --- |
| `agorakube_features.dashboard.enabled` | Enable Kubernetes dashboard | **False** *(default)* |
| `agorakube_features.dashboard.generate_admin_token` | Generate a default admin user + save token to /root/.kube/dashboardamin on Deploy node | **False** *(default)* |
| `agorakube_features.metrics_server.enabled` | Enable Metrics-Server | **False** *(default)* |
| `agorakube_features.ingress.controller` | Ingress Controller to install : nginx, ha-proxy, traefik | **nginx** *(default)* |
| `agorakube_features.ingress.release` | Ingress controller release to install. Only used if `agorakube_features.ingress.controller` set to "nginx" | **False** *(default)* |

## AGORAKUBE other settings
This section allows you to configure additional settings

| Parameter | Description | Values |
| --- | --- | --- |
| `agorakube_populate_etc_hosts` | Add all hostnames/IPs of AGORAKUBE Cluster to /etc/hosts file for all hosts. | **True** *(default)* |
| `agorakube_remove_etc_hosts` | Remove ALL /etc/hosts entries that are NOT defined in the etc_hosts group or etc_hosts variable | **False** *(default)* |
| `agorakube_backup_etc_hosts` | Optionally backup /etc/hosts each time a change is made | **False** *(default)* |
| `agorakube_encrypt_etcd_keys` | Array of keys/algorith used to crypt/decrypt data in etcd? Generate with : `head -c 32 /dev/urandom | base64` | **changeME !** *(default)* |
| `restoration_snapshot_file` | ETCD backup path to be restored | **none** *(default)* |
| `master_custom_alt_name`  | Optional DNS alt name to be added to kube-apiserver certificate | **""** *(default)* |

# Kubernetes deployment

Once all configuration files are set, run the following command to launch the Ansible playbook that will deploy the pre-configured Kubernetes cluster :

```
sudo ansible-playbook agorakube.yaml
```

# Create pod<a name="create-pod" />

After the pre-configured Kubernetes cluster is deployed, run the following command to deploy a sample Kubernetes pod with the busybox image:

```
cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: Pod
metadata:
  name: busybox-sleep
  namespace: default
spec:
  containers:
  - name: busybox
    image: busybox
    args:
    - sleep
    - "1000"
EOF
```

You should see an output similar to this:

```
pod/busybox-sleep created
```

Run the following command to verify if the deployed pod is running:

```
kubectl get pods
```

# How to use Ingress NGINX

## Basic usage

### Deployment

Create a simple app pod.

`kubectl run nginx --image=nginx --port 80`

Customize you website front page:

`kubectl exec nginx -- /bin/bash -c "echo My Super Website > /usr/share/nginx/html/index.html"`

Create a service ClusterIP in front of your pod:

`kubectl expose pod nginx --port=80 --name=frontend`

Create an Ingress with the following code to publish your `frontend` service
```
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: test-ingress
spec:
  rules:
  - host: foo.bar.com
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: frontend
            port:
              number: 80
```

Access your Ingress and see your website !

Warning: Sine Nginx Controller v1.0.0, Ingress must declare `spec.ingressClassName: nginx` !
Note: If you had already created an "ingress" resource before version v1.0.4 : add `spec.ingressClassName: nginx` to your resource.

Sample:
```
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: test-ingress
spec:
  ingressClassName: nginx
  rules:
  - host: foo.bar.com
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: frontend
            port:
              number: 80
```

# AGORAKUBE Log Architecture

Actually, AGORAKUBE configure Kubernetes components to write logs in "journalctl" an "/var/log/kubernetes/" directory.

In "/var/log/kubernetes/" directory, log file size is limited to 1800 MB.

Pods logs are stored in "/var/log/pods" directory.

ETCD logs are only present in "/var/log/etcd.log".

Run the following command to get system logs from host : `journalctl -xeu [SERVICE]`

# Configure Calico

With Agorakube, you can configure the way Calico discover node IFACE. In some cases, Agorakube master/nodes can have multiple Iface, with different names, order, and subnet/network. In that case, Calico will need your help to discover which Iface should be used to route between nodes. To do this, you can use "agorakube_network.calico_autodetection_method" parameter.
The following sections describe the available IP autodetection methods. (From https://docs.projectcalico.org/reference/node/configuration#ip-autodetection-methods)

## First-Found

The `first-found` option enumerates all interface IP addresses and returns the first valid IP address (based on IP version and type of address) on the first valid interface. Certain known “local” interfaces are omitted, such as the docker bridge. The order that both the interfaces and the IP addresses are listed is system dependent.

This is the default detection method. However, since this method only makes a very simplified guess, it is recommended to either configure the node with a specific IP address, or to use one of the other detection methods.

```
agorakube_network:
  calico_autodetection_method: "fisrt-found"
```

## can-reach=DESTINATION

The `can-reach` method uses your local routing to determine which IP address will be used to reach the supplied destination. Both IP addresses and domain names may be used.
```
agorakube_network:
  calico_autodetection_method: "can-reach=8.8.8.8"
```
or
```
agorakube_network:
  calico_autodetection_method: "can-reach=www.google.com"
```

## interface=INTERFACE-REGEX

The interface method uses the supplied interface regular expression (golang syntax) to enumerate matching interfaces and to return the first IP address on the first matching interface. The order that both the interfaces and the IP addresses are listed is system dependent.

```
agorakube_network:
  calico_autodetection_method: "interface=eth.*"
```

## skip-interface=INTERFACE-REGEX

The `skip-interface` method uses the supplied interface regular expression (golang syntax) to exclude interfaces and to return the first IP address on the first interface that not matching. The order that both the interfaces and the IP addresses are listed is system dependent.

```
agorakube_network:
  calico_autodetection_method: "skip-interface=enp6s0f0,eth.*"
```

## cidr=CIDR

The `cidr` method uses one or more comma-separated IP ranges in CIDR format to determine valid IP addresses to choose from.
```
agorakube_network:
  calico_autodetection_method: "cidr=10.10.20.0/24"
```

## Debug Calico

If you notice some network trouble with calico, deploy a calico pod with : `kubectl apply -f https://docs.projectcalico.org/manifests/calicoctl.yaml`

Then, print IFACE used by Calico with : `kubectl exec -ti -n kube-system calicoctl -- /calicoctl get nodes --allow-version-mismatch -o wide`

Calicoctl help command:  `kubectl exec -ti -n kube-system calicoctl -- /calicoctl -h`

# Configure Keycloak

Keycloak is used to enable SSO OIDC in Agorakube Kubernetes Cluster.

Keycloak can be enabled with the following parameters:

```
  keycloak_oidc:
    enabled: False
    admin:
      user: administrator
      password: P@ssw0rd
    auto_bootstrap:
        bootstrap_keycloak: true
        bootstrap_kube_apiserver: true
        populate_etc_hosts: true
        host: oidc.local.lan

    # And Keycloak Storage parametters
    #
    #
```

## Setup infrastructure

Keycloak is published with an Ingress entry powered by Nginx-Controller with TLS.

Agorakube automatically configure a "/etc/hosts" on kubernetes nodes to points to "nginx-controller" ClusterIP. So all Kubernetes master/nodes can access OIDC/Keycloak through "https://keycloak_oidc.auto_bootstraphost" (eg: https://oidc.local.lan).

If you wanna use SSO/OIDC **from outside the cluster**, you will need to publish your Nginx-Ingress through a LoadBalancer (Powered by Agorakube/MetalLB, or by your own infra) and configure your external DNS (Used by your users) to resolve "keycloak_oidc.auto_bootstraphost".

All users must be able to access keyclock through "https://keycloak_oidc.auto_bootstraphost". DO NOT USE PORT OTHER THAN 443 ! If you do so, you will notice an Authorization error on kube-APISERVER. ` "Unable to authenticate the request" err="invalid bearer token" `

# Upgrade And Downgrade Kubernetes with Agorakube

## One-Shoot Upgrade

Edit "./group_vars/all.yaml" file with the following parameters

```
agorakube_base_components:
  kubernetes:
    release: v1.21.1  (Desired K8S release)
    upgrade: true
```

Then apply your new Agorakube configuration from your agorakube root directory by running the following command:

`ansible-playbook agorakube.yaml`


## Rolling Upgrade

Agorakube support Rolling Upgrades for Kubernetes.
To make a rolling upgrade, edit "./group_vars/all.yaml" file with the following parameters

```
agorakube_base_components:
  kubernetes:
    release: v1.21.1  (Desired K8S release)
    upgrade: true
```
Then apply your new Agorakube configuration from your agorakube root directory by running the following command:

`ansible-playbook tools/rolling_update/rolling.yaml`

# Uninstall AGORAKUBE

To uninstall AGORAKUBE cluster, go to your AGORAKUBE source folder located on the deploy machine and run the following command:

```
ansible-playbook agorakube.yaml --tags uninstall
```
