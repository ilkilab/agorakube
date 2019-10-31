# AgoraKube

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)
[![FOSSA Status](https://app.fossa.com/api/projects/git%2Bgithub.com%2Filkilab%2Fagorakube.svg?type=shield)](https://app.fossa.com/projects/git%2Bgithub.com%2Filkilab%2Fagorakube?ref=badge_shield)
[![CII Best Practices](https://bestpractices.coreinfrastructure.org/projects/3104/badge)](https://bestpractices.coreinfrastructure.org/projects/3104)
[![Build Status](https://travis-ci.org/ilkilab/agorakube.svg?branch=master)](https://travis-ci.org/ilkilab/agorakube)



This project is aimed to provide the simplest way to install kubernetes on bare-metal, virtual & Cloud environments.
Actually, Ubuntu 18.04 (Bionic) amd64 and Centos 7/8  are supported, but several other operating systems will be available soon.


This project is still under development. 
Feedback is very welcome via the
[GitHub site](https://github.com/ilkilab/agorakube)
as issues or pull (merge) requests.

Master branch is stable.


[![asciicast](https://asciinema.org/a/Y58GrrJG3gPM6GvKsSMCZevbX.svg)](https://asciinema.org/a/Y58GrrJG3gPM6GvKsSMCZevbX)

## Summary

This is a list of points that will be explained in this Readme file for the AgoraKube project :

- What is AgoraKube
- How to install
- How to give feedback
- How to contribute
- Licensing

## What is AgoraKube

AgoraKube is an easy-to-use, stable Kubernetes distribution (Kubernetes v1.15, 1.16).

By its symplicity, AgoraKube provide a good way to deploy and manage K8S Clusters.

AgoraKube is based on Ansible scripts that install and configure Kubernetes components (control plane and data plane) quickly on bare-metal / VMs / Cloud Instances, as systemd services.

This distribution is also adaptive by offering the opportunity to customize your deployment and fit to your needs : OS (default : Ubuntu 18.04 (Bionic) - amd64), DNS Service (default : CoreDNS), Ingress Controller (default : Traefik), Container Runtime (Default : Containerd), certificats, Service-Mesh (available: Linkerd)...

This project is actually under development so other customizable options will be added soon.

## How to install

We regularly use a machine to deploy every cluster. We only use it for deployment and destroy it after.

### Setup

#### On the "deployment" node
Execute this command in order to install Ansible and clone the repository :
```
bash <(curl -s https://raw.githubusercontent.com/ilkilab/agorakube/master/setup-deploy.sh)
```
#### On the K8S nodes
Execute this command on each node to update them and install the last version of Python : 
```
bash <(curl -s https://raw.githubusercontent.com/ilkilab/agorakube/master/setup-hosts.sh)
```

### Installation instructions

To deploy your K8S cluster follow these [instructions](docs/instructions.md).

## How to give feedback

This project is still under development. 
Every feedback is very welcome via the
[GitHub site](https://github.com/ilkilab/agorakube)
as issues or pull (merge) requests.

You can also give use vulnerability reports by this way.
## How to contribute

This project is still under development. 
Contributions are very welcome via the
[GitHub site](https://github.com/ilkilab/agorakube)
as issues or pull (merge) requests.

See our [Code Of Conduct](https://github.com/ilkilab/agorakube/blob/master/CODE_OF_CONDUCT.md) and [CONTRIBUTING](https://github.com/ilkilab/agorakube/blob/master/docs/CONTRIBUTING.md) for more information.

## Licensing

All material here is released under the [APACHE 2.0 license](./LICENSE).
All material that is not executable, including all text when not executed,
is also released under the APACHE 2.0.
In SPDX terms, everything here is licensed under APACHE 2.0;
if it's not executable, including the text when extracted from code, it's
"(APACHE 2.0)".

Like almost all software today, this software depends on many
other components with their own licenses.
Not all components we depend on are APACHE 2.0-licensed, but all
*required* components are FLOSS. We prevent licensing issues
using various processes (see [CONTRIBUTING](./docs/CONTRIBUTING.md)).


[![FOSSA Status](https://app.fossa.io/api/projects/git%2Bgithub.com%2Filkilab%2Fagorakube.svg?type=large)](https://app.fossa.io/projects/git%2Bgithub.com%2Filkilab%2Fagorakube?ref=badge_large)
