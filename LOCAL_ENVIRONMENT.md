# Local AgoreKube Development Envionrment

Local environment is supported using vagrant. The document below describes pre-requisites for local environment for agorakube and how you can start using them.

## Pre Requisites

* Vagrant
* VirtualBox

## Environment customization

There are two files which can be modified to customize how the local environment will be setup in terms of number of nodes. By default it works with single node which
acts as deploy node for agorakube and as well as master and worker node for kubernetes. 

The configuration files for Vagrant based local environment are located in test_lab folder.

Number of nodes can be changed by modifying the Vagrantfile and uncommenting node1 and node2 blocks, note please only uncomment the lines between *# Node[12] Block START* and *# Node[12] Block END*

After modifying the Vagrantfile please adjust hosts.vagrant accordingly and make sure to *update the advertise_ip_masters* to be same as the IP of either deploy node in case of 
single node (default) local environment or to the ip of node1 in case of multi-node local environment.

## Start the environment

Simply goto test_lab folder and run the following command:

`vagrant up`
