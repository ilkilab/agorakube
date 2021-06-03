# Local AGORAKUBE Development Environment

You can create a local environment by using Vagrant. 
The document below describes pre-requisites for AGORAKUBE local environment and how you can start using them.


## Pre-requisites

* [Vagrant](https://www.vagrantup.com/downloads)
* [VirtualBox](https://www.virtualbox.org/wiki/Downloads)


## Environment customization

We use Vagrant and VirtualBox to deploy local environments.

Test environments are located in [labs](./labs) folder which contains a set of sub-folders for each configuration you may want to implement. Feel free to customize VagrantFiles according to your need !


## Start the environment

1) Simply open a terminal and go to [labs/multi-nodes](./labs/multi-nodes) or [labs/all-in-one](./labs/all-in-one) folder depending on the configuration you want to deploy.


2) Once you are located on the folder that contains your file "Vagrantfile", run the command :

```
vagrant up
```

3) Once ILKE installation is finished, a kubeconfig file ("config") is generated next to your Vagrantfile. You can use this file to manage your Kubernetes installation with [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/), or you can connect to the deploy machine with the following command :

```
vagrant ssh deploy (all-in-one configuration)

vagrant ssh worker1 (multi-nodes configuration)
```

4) Kubernetes CLI "kubectl" is configured for root user, so use the following command to become root :

```
sudo su
```

5) You can now enjoy your AGORAKUBE/K8S fresh cluster ! Use the following command to print K8S version :

```
kubectl version
```


6) If you want to stop your kubernetes cluster, juste go to your Vagrantfile folder and run :

```
vagrant halt -f
```

You can also start again your K8S cluster with `vagrant up`. If `vagrant up` does not start all the machines correctly, simply start them manually on VirtualBox.


7) If you want to destroy your local cluster, just run :

```
vagrant destroy -f 
```


## Best practices

If you want to test your branch in the local environment, be sure to follow these tips :

1) Create a test folder in which you will clone your branch :

```
mkdir test

cd test

git clone https://github.com/repo/agorakube.git -b test-branch
```


2) Copy the "hosts.yaml" file to your branch :

```
cp agorakube/hosts test/agorakube/hosts
```


3) You are now ready to test :

```
source /usr/local/agorakube-env/bin/activate

ansible-playbook agorakube.yaml
```
