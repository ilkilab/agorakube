# AGORAKUBE KUBERNETES ENGINE
<!-- ALL-CONTRIBUTORS-BADGE:START - Do not remove or modify this section -->
[![All Contributors](https://img.shields.io/badge/all_contributors-21-orange.svg?style=flat-square)](#contributors-)
<!-- ALL-CONTRIBUTORS-BADGE:END -->

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)
[![CII Best Practices](https://bestpractices.coreinfrastructure.org/projects/3104/badge)](https://bestpractices.coreinfrastructure.org/projects/3104)
[![FOSSA Status](https://app.fossa.com/api/projects/git%2Bgithub.com%2Filkilab%2Fagorakube.svg?type=shield)](https://app.fossa.com/projects/git%2Bgithub.com%2Filkilab%2Fagorakube?ref=badge_shield)
[![ansible-lint-agorakube](https://github.com/ilkilab/agorakube/actions/workflows/ansible-lint.yaml/badge.svg)](https://github.com/ilkilab/agorakube/actions/workflows/ansible-lint.yaml)

<p align="center">
<img src="./images/agorakube-logo.svg" width="450" alt="Agorakube" title="Agorakube" />
</p>
<p>
<a href="https://github.com/cncf/k8s-conformance">
<img src="https://raw.githubusercontent.com/cncf/artwork/master/projects/kubernetes/certified-kubernetes/versionless/color/certified-kubernetes-color.svg?sanitize=true" width="100" alt="k8s-conformance-v1.16" title="https://github.com/cncf/k8s-conformance/tree/master/v1.16/agorakube"/>
</a>
<a href="https://landscape.cncf.io/?selected=agora-kube">
<img src="https://raw.githubusercontent.com/cncf/artwork/master/other/cncf-landscape/stacked/color/cncf-landscape-stacked-color.svg?sanitize=true" width="100" alt="Agorakube is a cncf landscap project" title="Agorakube is a cncf landscap project"/>
</a>
</p>

This project aims to provide the simplest way to install Kubernetes on AMD-64 bare-metal, virtual & Cloud environments.
Currently, Ubuntu 18.04 & 20.04,  and Debian 10  are supported, but several other operating systems will be available soon.

Master branch is stable.

## Table of Contents

The following items are explained in this Readme file for the Agorakube project :

- [What is AGORAKUBE](#what-is-agorakube)
- [How to install](#how-to-install)
- [How to give feedback](#how-to-give-feedback)
- [How to contribute](#how-to-contribute)
- [Community](#community)
- [Licensing](#licensing)

## What is AGORAKUBE

Agorakube is an easy-to-use, stable Kubernetes distribution.

Agorakube provides a simple, user-friendly way to deploy and manage K8S Clusters.

Agorakube is based on Ansible scripts that install and configure Kubernetes components (control plane and data plane) quickly on bare-metal / VMs / Cloud Instances, as systemd services.

This distribution is also adaptive by offering the opportunity to customize your deployment to fit your needs :
* OS : Ubuntu-18.04/20.04-amd64 and  Debian-10-amd64
* DNS Service: CoreDNS
* Nginx Ingress Controller
* Container Runtime: Containerd
* Certificats: Self Signed PKI using OpenSSL
* CNI plugin: Calico (VxLAN Cross-Subnet for pod-to-pod network and NetworkPolicy enabled)
* MetalLB (L2/ARP mode for external LB)
* Metrics-Server
* Kubernetes-Dashboard

![AGORAKUBE](./images/AGORAKUBE.png)

This project is currently under active development so other customizable options will be added soon.

[![asciicast](https://asciinema.org/a/Y58GrrJG3gPM6GvKsSMCZevbX.svg)](https://asciinema.org/a/Y58GrrJG3gPM6GvKsSMCZevbX)

Below is a diagram of the high-level architecture deployed by AGORAKUBE :
![Architecture](./images/AGORAKUBE_diagram.png)

## How to install

To deploy your K8S cluster follow these [instructions](docs/instructions.md).

## How to try

You need to install on your computer VirtualBox and Vagrant tools then download "agorakube/labs/multi-nodes/Vagrantfile" file.

Then, with your terminal/cmd go to the directory that contains your Vagrantfile file and use command "vagrant up".

After Agorakube installtion, you can login to your master node with command "vagrant ssh master10" and use "kubectl" as root ( "sudo su" command)

## How to give feedback

All feedback is welcome via the
[GitHub site](https://github.com/ilkilabs/agorakube)
as issues or pull (merge) requests.

You can also give use vulnerability reports by this way.
## How to contribute


See our [Code Of Conduct](https://github.com/ilkilabs/agorakube/blob/master/CODE_OF_CONDUCT.md) and [CONTRIBUTING](https://github.com/ilkilabs/agorakube/blob/master/docs/CONTRIBUTING.md) for more information.

## Community

Join Agorakube's community for discussion and ask questions : [AGORAKUBE's Slack](http://slack.agorakube.ilkilabs.io/)

Channels :
- **#general** - For general purpose (news, events...)
- **#developers** - For people who contribute to Agorakube by developing features
- **#end-users** - For end users who want to give us feedback
- **#random** - As its name suggests, for random discussions :)

## Licensing

All material here is released under the [APACHE 2.0 license](./LICENSE).  
All material that is not executable, including all text when not executed,
is also released under APACHE 2.0.  
In SPDX terms, everything here is licensed under APACHE 2.0;  
if it's not executable, including the text when extracted from code, it's
"(APACHE 2.0)".

As with almost all software today, Agorakube depends on many
other components with their own licenses.  
Not all components we depend on are APACHE 2.0-licensed, but all
*required* components are FLOSS.   
We use various processes to prevent licensing issues (see [CONTRIBUTING](./docs/CONTRIBUTING.md)).


[![FOSSA Status](https://app.fossa.com/api/projects/git%2Bgithub.com%2Filkilab%2Fagorakube.svg?type=large)](https://app.fossa.com/projects/git%2Bgithub.com%2Filkilab%2Fagorakube?ref=badge_large)

## Contributors ✨

Thanks goes to these wonderful people ([emoji key](https://allcontributors.org/docs/en/emoji-key)):
<!-- ALL-CONTRIBUTORS-LIST:START - Do not remove or modify this section -->
<!-- prettier-ignore-start -->
<!-- markdownlint-disable -->
<table>
  <tr>
    <td align="center"><a href="https://github.com/pranavbaitule"><img src="https://avatars.githubusercontent.com/u/72313242?v=4?s=100" width="100px;" alt=""/><br /><sub><b>pranavbaitule</b></sub></a><br /><a href="https://github.com/ilkilab/agorakube/commits?author=pranavbaitule" title="Documentation">📖</a></td>
    <td align="center"><a href="https://www.ilki.fr/"><img src="https://avatars.githubusercontent.com/u/43336050?v=4?s=100" width="100px;" alt=""/><br /><sub><b>pierre villard</b></sub></a><br /><a href="https://github.com/ilkilab/agorakube/commits?author=pierreilki" title="Documentation">📖</a> <a href="https://github.com/ilkilab/agorakube/commits?author=pierreilki" title="Code">💻</a> <a href="#mentoring-pierreilki" title="Mentoring">🧑‍🏫</a> <a href="#projectManagement-pierreilki" title="Project Management">📆</a></td>
    <td align="center"><a href="https://github.com/gaelfr29"><img src="https://avatars.githubusercontent.com/u/43063988?v=4?s=100" width="100px;" alt=""/><br /><sub><b>gaelfr29</b></sub></a><br /><a href="https://github.com/ilkilab/agorakube/commits?author=gaelfr29" title="Documentation">📖</a> <a href="#projectManagement-gaelfr29" title="Project Management">📆</a> <a href="#ideas-gaelfr29" title="Ideas, Planning, & Feedback">🤔</a> <a href="#business-gaelfr29" title="Business development">💼</a></td>
    <td align="center"><a href="https://github.com/ur2p0"><img src="https://avatars.githubusercontent.com/u/32265063?v=4?s=100" width="100px;" alt=""/><br /><sub><b>Adrien Huerre</b></sub></a><br /><a href="https://github.com/ilkilab/agorakube/commits?author=ur2p0" title="Documentation">📖</a> <a href="#projectManagement-ur2p0" title="Project Management">📆</a> <a href="#ideas-ur2p0" title="Ideas, Planning, & Feedback">🤔</a> <a href="#business-ur2p0" title="Business development">💼</a></td>
    <td align="center"><a href="https://github.com/bryanILKI"><img src="https://avatars.githubusercontent.com/u/79568169?v=4?s=100" width="100px;" alt=""/><br /><sub><b>bryanILKI</b></sub></a><br /><a href="https://github.com/ilkilab/agorakube/commits?author=bryanILKI" title="Documentation">📖</a> <a href="https://github.com/ilkilab/agorakube/commits?author=bryanILKI" title="Code">💻</a> <a href="#maintenance-bryanILKI" title="Maintenance">🚧</a></td>
    <td align="center"><a href="https://github.com/sabrine-hammami"><img src="https://avatars.githubusercontent.com/u/79543319?v=4?s=100" width="100px;" alt=""/><br /><sub><b>sabrine-hammami</b></sub></a><br /><a href="https://github.com/ilkilab/agorakube/commits?author=sabrine-hammami" title="Documentation">📖</a> <a href="https://github.com/ilkilab/agorakube/commits?author=sabrine-hammami" title="Code">💻</a> <a href="#maintenance-sabrine-hammami" title="Maintenance">🚧</a></td>
    <td align="center"><a href="http://hameedullah.com"><img src="https://avatars.githubusercontent.com/u/59614?v=4?s=100" width="100px;" alt=""/><br /><sub><b>Hameedullah Khan</b></sub></a><br /><a href="https://github.com/ilkilab/agorakube/commits?author=hameedullah" title="Documentation">📖</a> <a href="https://github.com/ilkilab/agorakube/commits?author=hameedullah" title="Code">💻</a></td>
  </tr>
  <tr>
    <td align="center"><a href="https://github.com/Flybro"><img src="https://avatars.githubusercontent.com/u/10743439?v=4?s=100" width="100px;" alt=""/><br /><sub><b>Big Bill</b></sub></a><br /><a href="https://github.com/ilkilab/agorakube/commits?author=Flybro" title="Documentation">📖</a> <a href="https://github.com/ilkilab/agorakube/commits?author=Flybro" title="Code">💻</a></td>
    <td align="center"><a href="https://github.com/husseinfahmy"><img src="https://avatars.githubusercontent.com/u/12388623?v=4?s=100" width="100px;" alt=""/><br /><sub><b>Hussein Fahmy</b></sub></a><br /><a href="https://github.com/ilkilab/agorakube/commits?author=husseinfahmy" title="Documentation">📖</a> <a href="https://github.com/ilkilab/agorakube/commits?author=husseinfahmy" title="Code">💻</a></td>
    <td align="center"><a href="https://github.com/rushilgala"><img src="https://avatars.githubusercontent.com/u/18123323?v=4?s=100" width="100px;" alt=""/><br /><sub><b>rushilgala</b></sub></a><br /><a href="https://github.com/ilkilab/agorakube/commits?author=rushilgala" title="Documentation">📖</a> <a href="https://github.com/ilkilab/agorakube/commits?author=rushilgala" title="Code">💻</a></td>
    <td align="center"><a href="https://github.com/odidev"><img src="https://avatars.githubusercontent.com/u/40816837?v=4?s=100" width="100px;" alt=""/><br /><sub><b>odidev</b></sub></a><br /><a href="https://github.com/ilkilab/agorakube/commits?author=odidev" title="Code">💻</a></td>
    <td align="center"><a href="http://aaronjohnson.io"><img src="https://avatars.githubusercontent.com/u/1386238?v=4?s=100" width="100px;" alt=""/><br /><sub><b>Aaron Johnson</b></sub></a><br /><a href="https://github.com/ilkilab/agorakube/commits?author=acjohnson" title="Documentation">📖</a> <a href="https://github.com/ilkilab/agorakube/commits?author=acjohnson" title="Code">💻</a></td>
    <td align="center"><a href="https://github.com/msouvatdy"><img src="https://avatars.githubusercontent.com/u/49560112?v=4?s=100" width="100px;" alt=""/><br /><sub><b>msouvatdy</b></sub></a><br /><a href="https://github.com/ilkilab/agorakube/commits?author=msouvatdy" title="Documentation">📖</a> <a href="https://github.com/ilkilab/agorakube/commits?author=msouvatdy" title="Code">💻</a></td>
    <td align="center"><a href="https://github.com/tyb3n"><img src="https://avatars.githubusercontent.com/u/16243465?v=4?s=100" width="100px;" alt=""/><br /><sub><b>tyb3n</b></sub></a><br /><a href="https://github.com/ilkilab/agorakube/commits?author=tyb3n" title="Documentation">📖</a> <a href="https://github.com/ilkilab/agorakube/commits?author=tyb3n" title="Code">💻</a></td>
  </tr>
  <tr>
    <td align="center"><a href="https://ericstumbo.tech"><img src="https://avatars.githubusercontent.com/u/25944964?v=4?s=100" width="100px;" alt=""/><br /><sub><b>Eric Stumbo</b></sub></a><br /><a href="https://github.com/ilkilab/agorakube/commits?author=digikin" title="Code">💻</a></td>
    <td align="center"><a href="https://github.com/rob-coq"><img src="https://avatars.githubusercontent.com/u/44269196?v=4?s=100" width="100px;" alt=""/><br /><sub><b>rob-coq</b></sub></a><br /><a href="https://github.com/ilkilab/agorakube/commits?author=rob-coq" title="Documentation">📖</a> <a href="https://github.com/ilkilab/agorakube/commits?author=rob-coq" title="Code">💻</a></td>
    <td align="center"><a href="https://github.com/HaroldIlki"><img src="https://avatars.githubusercontent.com/u/90386162?v=4?s=100" width="100px;" alt=""/><br /><sub><b>HaroldIlki</b></sub></a><br /><a href="https://github.com/ilkilab/agorakube/commits?author=HaroldIlki" title="Documentation">📖</a> <a href="https://github.com/ilkilab/agorakube/commits?author=HaroldIlki" title="Code">💻</a></td>
    <td align="center"><a href="https://github.com/robakerson"><img src="https://avatars.githubusercontent.com/u/85378187?v=4?s=100" width="100px;" alt=""/><br /><sub><b>Bob Akerson</b></sub></a><br /><a href="https://github.com/ilkilab/agorakube/commits?author=robakerson" title="Documentation">📖</a></td>
    <td align="center"><a href="https://github.com/jeremyj563"><img src="https://avatars.githubusercontent.com/u/12220868?v=4?s=100" width="100px;" alt=""/><br /><sub><b>jeremyj563</b></sub></a><br /><a href="https://github.com/ilkilab/agorakube/commits?author=jeremyj563" title="Code">💻</a></td>
    <td align="center"><a href="http://ow.ly/v40s50zwWhl"><img src="https://avatars.githubusercontent.com/u/12658912?v=4?s=100" width="100px;" alt=""/><br /><sub><b>Pratik Raj</b></sub></a><br /><a href="https://github.com/ilkilab/agorakube/commits?author=Rajpratik71" title="Code">💻</a></td>
    <td align="center"><a href="https://github.com/McgovernJP"><img src="https://avatars.githubusercontent.com/u/50113854?v=4?s=100" width="100px;" alt=""/><br /><sub><b>McgovernJP</b></sub></a><br /><a href="https://github.com/ilkilab/agorakube/commits?author=McgovernJP" title="Documentation">📖</a></td>
  </tr>
</table>

<!-- markdownlint-restore -->
<!-- prettier-ignore-end -->

<!-- ALL-CONTRIBUTORS-LIST:END -->

This project follows the [all-contributors](https://github.com/all-contributors/all-contributors) specification. Contributions of any kind welcome!
