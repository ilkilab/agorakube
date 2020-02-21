# Local AgoraKube Development Environment

You can create a local environment by using Vagrant. 
The document below describes pre-requisites for Agorakube local environment and how you can start using them.

## Pre-requisites

* Vagrant
* VirtualBox

## Environment customization

There are two files which can be modified to customize the local environment, especially in terms of number of nodes. By default, it works with single node which acts as : 
- Agorakube deployment node used to deploy all components
- master and worker node for Kubernetes

The configuration files for Vagrant based local environment are located in [test_lab folder](/test_lab).

**Note :** First, you can choose the base OS (Ubuntu or CentOS) of you local environment by modifying [Vagrantfile](/test_lab/Vagrantfile). 

If you want to change the number of nodes :
1. You can first modify the [Vagrantfile](/test_lab/Vagrantfile) by uncommenting blocks corresponding to node1 and node2.
   - **Note :** Only uncomment the lines between *# Node[12] Block START* and *# Node[12] Block END*
2. Next, adjust [hosts.vagrant](/test_lab/hosts.vagrant) file accordingly by uncommenting the desired lines.
   - **Note :** Make sure to update the *advertise_ip_masters* :
     - In case of a single node deployment (default), the IP must correspond to the deployment node IP
     - In case of multi-node deployment, the IP must correspond to the node1 IP 
    

## Start the environment

1) Simply open a terminal and goto test_lab folder and then run the following command:

`vagrant up`

2) One Agorakube installation is finished, connect to the deploy manachine with the following command:

`vagrant ssh deploy`

3) Kubernetes CLI "kubectl" is configured for root user, so use the following command to become root:

`sudo su`

4) You can now enjoy your Agorakube/K8S fresh cluster ! Use the following command to print K8S version:

`kubectl version`
