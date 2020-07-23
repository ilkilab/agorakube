# Local AgoraKube Development Environment

You can create a local environment by using Vagrant. 
The document below describes pre-requisites for Agorakube local environment and how you can start using them.

## Pre-requisites

* Vagrant
* VirtualBox

## Environment customization

We use Vagrant and VirtualBox to deploy local environments.

Test environments are located in [labs](./labs) folder

This [labs](./labs) folder contains a set of sub-folders for each configuration you may want to implement. Feel free to customize VagrantFiles according to your need !
    

## Start the environment

1) Simply open a terminal and goto [labs/XX](./labs) folder where XX is the configuration you went to deploy.

2) Once you are located on the folder that contains your file "Vagrantfile", run the command:

`vagrant up`

3) Once Agorakube installation is finished, a kubeconfig file ("config") is generated next to your Vagrantfile. You can use this file to manage your Kubernetes installation with [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/), or you can connect to the deploy manachine with the following command:

`vagrant ssh deploy`

4) Kubernetes CLI "kubectl" is configured for root user, so use the following command to become root:

`sudo su`

5) You can now enjoy your Agorakube/K8S fresh cluster ! Use the following command to print K8S version:

`kubectl version`

6) IF you want to stop your kubernetes cluster, juste go to your Vagrantfile folder and run:

`vagrant halt -f`     You can also start again your K8S cluster with ```vagrant up```

7) If you want to destroy your local cluster, just run:

`vagrant destroy -f` 
