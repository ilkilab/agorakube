# ⚠️ Repo Archive Notice

As of Mars 2021, Agorakube code in this repo will no longer be updated/maintained.
Please refer to ILKE project instead : https://github.com/ilkilabs/ilke


# AgoraKube

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)
[![FOSSA Status](https://app.fossa.com/api/projects/git%2Bgithub.com%2Filkilab%2Fagorakube.svg?type=shield)](https://app.fossa.com/projects/git%2Bgithub.com%2Filkilab%2Fagorakube?ref=badge_shield)
[![CII Best Practices](https://bestpractices.coreinfrastructure.org/projects/3104/badge)](https://bestpractices.coreinfrastructure.org/projects/3104)
[![Build Status](https://travis-ci.org/ilkilab/agorakube.svg?branch=master)](https://travis-ci.org/ilkilab/agorakube)


<p align="center">
<img src="./images/agorakube-logo.svg" width="450" alt="Agorakube" title="Agorakube" />
</p>
<p>
<img src="https://raw.githubusercontent.com/cncf/artwork/master/projects/kubernetes/certified-kubernetes/versionless/color/certified-kubernetes-color.svg?sanitize=true" width="100" alt="k8s-conformance-v1.16" title="https://github.com/cncf/k8s-conformance/tree/master/v1.16/agorakube"/>
<img src="https://raw.githubusercontent.com/cncf/artwork/master/other/cncf-landscape/stacked/color/cncf-landscape-stacked-color.svg?sanitize=true" width="100" alt="Agorakube is a cncf landscap project" title="Agorakube is a cncf landscap project"/>
</p>

This project is aimed to provide the simplest way to install kubernetes on AMD-64 bare-metal, virtual & Cloud environments.
Currently, Ubuntu 18.04 & 20.04,  Centos 7 and Debian 10  are supported, but several other operating systems will be available soon.

Official documentation is available at [Agorakube Website](https://agorakube.ilkilabs.io/)

Master branch is stable.

**If you want to install Kubernetes V1.19+, please use the "core" branch.(Support v16 to v19)**

Read this in [French](https://github.com/ilkilab/agorakube/blob/master/docs/translations/FR/README.fr.md)

Since November 2019, [Agorakube](https://agorakube.ilkilabs.io/) has been certified by the "Kubernetes Conformance Program" and is a project of [the cncf landscape](https://landscape.cncf.io/selected=agora-kube).

[![asciicast](https://asciinema.org/a/Y58GrrJG3gPM6GvKsSMCZevbX.svg)](https://asciinema.org/a/Y58GrrJG3gPM6GvKsSMCZevbX)

## Table of Contents

This is a list of points that will be explained in this Readme file for the [AgoraKube](https://agorakube.ilkilabs.io/) project :

- [What is AgoraKube](#what-is-agoraKube)
- [How to install](#how-to-install)
- [How to give feedback](#how-to-give-feedback)
- [How to contribute](#how-to-contribute)
- [Community](#community)
- [Licensing](#licensing)

## What is AgoraKube

[AgoraKube](https://agorakube.ilkilabs.io/) is an easy-to-use, stable Kubernetes distribution (Kubernetes v1.15, 1.16, 1.17, 1.18).

By its symplicity, [AgoraKube](https://agorakube.ilkilabs.io/) provide a good way to deploy and manage K8S Clusters.

[AgoraKube](https://agorakube.ilkilabs.io/) is based on Ansible scripts that install and configure Kubernetes components (control plane and data plane) quickly on bare-metal / VMs / Cloud Instances, as systemd services.

This distribution is also adaptive by offering the opportunity to customize your deployment and fit to your needs : 
* OS : Ubuntu-18.04/20.04-amd64 and Centos 7.X-amd64, Debian-10-amd64 
* DNS Service: CoreDNS
* Ingress Controller Traefik (Default) & HA-Proxy & Nginx
* Container Runtime: Containerd (Default) & Docker
* Certificats: Self Signed PKI
* Service-Mesh: available: Linkerd
* Storage: Rook Ceph Block with StorageClass, and MinIO for Object Storage
* Registry: Harbor full featured
* Monitoring: Prometheus/Grafana
* CNI plugin: Flannel, Calico, Kube-router
* Packaging: Helm
* Self service application portal: Kubeapps
* ...

This project is currently under active development so other customizable options will be added soon.

## How to install

We regularly use a machine to deploy every cluster. We only use it for deployment.

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

Every feedback is very welcome via the
[GitHub site](https://github.com/ilkilab/agorakube)
as issues or pull (merge) requests.

You can also give use vulnerability reports by this way.
## How to contribute

See our [Code Of Conduct](https://github.com/ilkilab/agorakube/blob/master/CODE_OF_CONDUCT.md) and [CONTRIBUTING](https://github.com/ilkilab/agorakube/blob/master/docs/CONTRIBUTING.md) for more information.

## Community

Join Agorakube's community for discussion and ask questions : [Agorakube's Slack](http://slack.agorakube.ilkilabs.io/)

Channels :
- **#general** - For general purpose (news, events...)
- **#developpers** - For people who contribute to Agorakube by developing features
- **#end-users** - For end users who want to give us feedbacks
- **#random** - As its name suggests, for random discussions :)

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
