# AGORAKUBE KUBERNETES ENGINE
<!-- ALL-CONTRIBUTORS-BADGE:START - Do not remove or modify this section -->
[![All Contributors](https://img.shields.io/badge/all_contributors-1-orange.svg?style=flat-square)](#contributors-)
<!-- ALL-CONTRIBUTORS-BADGE:END -->
<!-- ALL-CONTRIBUTORS-BADGE:START - Do not remove or modify this section -->
[![All Contributors](https://img.shields.io/badge/all_contributors-13-orange.svg?style=flat-square)](#contributors-)
<!-- ALL-CONTRIBUTORS-BADGE:END -->

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)
[![CII Best Practices](https://bestpractices.coreinfrastructure.org/projects/3104/badge)](https://bestpractices.coreinfrastructure.org/projects/3104)
[![FOSSA Status](https://app.fossa.com/api/projects/git%2Bgithub.com%2Filkilab%2Fagorakube.svg?type=shield)](https://app.fossa.com/projects/git%2Bgithub.com%2Filkilab%2Fagorakube?ref=badge_shield)


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

This project is aimed to provide the simplest way to install kubernetes on AMD-64 bare-metal, virtual & Cloud environments.
Currently, Ubuntu 18.04 & 20.04,  Centos 7 and Debian 10  are supported, but several other operating systems will be available soon.

Master branch is stable.

## Table of Contents

This is a list of points that will be explained in this Readme file for the Agorakube project :

- [What is AGORAKUBE](#what-is-agorakube)
- [How to install](#how-to-install)
- [How to give feedback](#how-to-give-feedback)
- [How to contribute](#how-to-contribute)
- [Community](#community)
- [Licensing](#licensing)

## What is AGORAKUBE

Agorakube is an easy-to-use, stable Kubernetes distribution (Kubernetes v1.15, 1.16, 1.17, 1.18, 1.19, 1.20, 1.21).

By its symplicity, AGORAKUBE provide a good way to deploy and manage K8S Clusters.

Agorakube is based on Ansible scripts that install and configure Kubernetes components (control plane and data plane) quickly on bare-metal / VMs / Cloud Instances, as systemd services.

This distribution is also adaptive by offering the opportunity to customize your deployment and fit to your needs : 
* OS : Ubuntu-18.04/20.04-amd64 and Centos 7.X-amd64, Debian-10-amd64 
* DNS Service: CoreDNS
* Ingress Controller Traefik v2 & HA-Proxy & Nginx (Default)
* Container Runtime: Containerd (Default) & Docker
* Certificats: Self Signed PKI using OpenSSL
* Storage: OpenEBS (Jiva and HostPath)
* Monitoring: Prometheus/Grafana/node-Exporter
* CNI plugin: Kube-router, Calico (VxLAN Cross-Subnet)
* MetalLB (L2/ARP mode for external LB)
* Metrics-Server
* Kubernetes-Dashboard
* Kubernetes ConfigMap and Secret Reloader
* Logrotate
* OIDC/SSO with Keycloak

![AGORAKUBE](./images/AGORAKUBE.png)

This project is currently under active development so other customizable options will be added soon.

[![asciicast](https://asciinema.org/a/Y58GrrJG3gPM6GvKsSMCZevbX.svg)](https://asciinema.org/a/Y58GrrJG3gPM6GvKsSMCZevbX)

## How to install

To deploy your K8S cluster follow these [instructions](docs/instructions.md).

## How to give feedback

Every feedback is very welcome via the
[GitHub site](https://github.com/ilkilabs/agorakube)
as issues or pull (merge) requests.

You can also give use vulnerability reports by this way.
## How to contribute


See our [Code Of Conduct](https://github.com/ilkilabs/agorakube/blob/master/CODE_OF_CONDUCT.md) and [CONTRIBUTING](https://github.com/ilkilabs/agorakube/blob/master/docs/CONTRIBUTING.md) for more information.

## Community

Join Agorakube's community for discussion and ask questions : [AGORAKUBE's Slack](http://slack.agorakube.ilkilabs.io/)

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

Lagorakube almost all software today, this software depends on many
other components with their own licenses.
Not all components we depend on are APACHE 2.0-licensed, but all
*required* components are FLOSS. We prevent licensing issues
using various processes (see [CONTRIBUTING](./docs/CONTRIBUTING.md)).


[![FOSSA Status](https://app.fossa.com/api/projects/git%2Bgithub.com%2Filkilab%2Fagorakube.svg?type=large)](https://app.fossa.com/projects/git%2Bgithub.com%2Filkilab%2Fagorakube?ref=badge_large)

## Contributors ✨

Thanks goes to these wonderful people ([emoji key](https://allcontributors.org/docs/en/emoji-key)):
<!-- ALL-CONTRIBUTORS-LIST:START - Do not remove or modify this section -->
<!-- prettier-ignore-start -->
<!-- markdownlint-disable -->
<table>
  <tr>
    <td align="center"><a href="https://github.com/pranavbaitule"><img src="https://avatars.githubusercontent.com/u/72313242?v=4?s=100" width="100px;" alt=""/><br /><sub><b>pranavbaitule</b></sub></a><br /><a href="https://github.com/ilkilab/agorakube/commits?author=pranavbaitule" title="Documentation">📖</a></td>
  </tr>
</table>

<!-- markdownlint-restore -->
<!-- prettier-ignore-end -->

<!-- ALL-CONTRIBUTORS-LIST:END -->

<!-- ALL-CONTRIBUTORS-LIST:START - Do not remove or modify this section -->
<!-- prettier-ignore-start -->
<!-- markdownlint-disable -->
<table>
  <tr>
    <td align="center"><a href="https://www.ilki.fr/"><img src="https://avatars.githubusercontent.com/u/43336050?v=4?s=100" width="100px;" alt=""/><br /><sub><b>pierre villard</b></sub></a><br /><a href="#projectManagement-pierreilki" title="Project Management">📆</a> <a href="https://github.com/ilkilabs/agorakube/commits?author=pierreilki" title="Code">💻</a> <a href="#mentoring-pierreilki" title="Mentoring">🧑‍🏫</a> <a href="https://github.com/ilkilabs/agorakube/commits?author=pierreilki" title="Documentation">📖</a></td>
    <td align="center"><a href="https://github.com/bryanILKI"><img src="https://avatars.githubusercontent.com/u/79568169?v=4?s=100" width="100px;" alt=""/><br /><sub><b>bryanILKI</b></sub></a><br /><a href="https://github.com/ilkilabs/agorakube/commits?author=bryanILKI" title="Code">💻</a> <a href="#maintenance-bryanILKI" title="Maintenance">🚧</a> <a href="https://github.com/ilkilabs/agorakube/commits?author=bryanILKI" title="Documentation">📖</a></td>
    <td align="center"><a href="https://github.com/sabrine-hammami"><img src="https://avatars.githubusercontent.com/u/79543319?v=4?s=100" width="100px;" alt=""/><br /><sub><b>sabrine-hammami</b></sub></a><br /><a href="https://github.com/ilkilabs/agorakube/commits?author=sabrine-hammami" title="Code">💻</a> <a href="#maintenance-sabrine-hammami" title="Maintenance">🚧</a> <a href="https://github.com/ilkilabs/agorakube/commits?author=sabrine-hammami" title="Documentation">📖</a></td>
    <td align="center"><a href="https://github.com/ur2p0"><img src="https://avatars.githubusercontent.com/u/32265063?v=4?s=100" width="100px;" alt=""/><br /><sub><b>Adrien Huerre</b></sub></a><br /><a href="https://github.com/ilkilabs/agorakube/commits?author=ur2p0" title="Documentation">📖</a> <a href="#content-ur2p0" title="Content">🖋</a> <a href="#projectManagement-ur2p0" title="Project Management">📆</a></td>
    <td align="center"><a href="https://github.com/gaelfr29"><img src="https://avatars.githubusercontent.com/u/43063988?v=4?s=100" width="100px;" alt=""/><br /><sub><b>gaelfr29</b></sub></a><br /><a href="#business-gaelfr29" title="Business development">💼</a> <a href="#projectManagement-gaelfr29" title="Project Management">📆</a></td>
    <td align="center"><a href="http://aaronjohnson.io"><img src="https://avatars.githubusercontent.com/u/1386238?v=4?s=100" width="100px;" alt=""/><br /><sub><b>Aaron Johnson</b></sub></a><br /><a href="https://github.com/ilkilabs/agorakube/commits?author=acjohnson" title="Code">💻</a> <a href="https://github.com/ilkilabs/agorakube/commits?author=acjohnson" title="Documentation">📖</a></td>
    <td align="center"><a href="http://hameedullah.com"><img src="https://avatars.githubusercontent.com/u/59614?v=4?s=100" width="100px;" alt=""/><br /><sub><b>Hameedullah Khan</b></sub></a><br /><a href="https://github.com/ilkilabs/agorakube/commits?author=hameedullah" title="Code">💻</a> <a href="https://github.com/ilkilabs/agorakube/commits?author=hameedullah" title="Documentation">📖</a></td>
  </tr>
  <tr>
    <td align="center"><a href="https://github.com/Flybro"><img src="https://avatars.githubusercontent.com/u/10743439?v=4?s=100" width="100px;" alt=""/><br /><sub><b>Big Bill</b></sub></a><br /><a href="https://github.com/ilkilabs/agorakube/commits?author=Flybro" title="Code">💻</a> <a href="https://github.com/ilkilabs/agorakube/commits?author=Flybro" title="Documentation">📖</a></td>
    <td align="center"><a href="https://github.com/husseinfahmy"><img src="https://avatars.githubusercontent.com/u/12388623?v=4?s=100" width="100px;" alt=""/><br /><sub><b>Hussein Fahmy</b></sub></a><br /><a href="https://github.com/ilkilabs/agorakube/commits?author=husseinfahmy" title="Code">💻</a></td>
    <td align="center"><a href="https://github.com/rushilgala"><img src="https://avatars.githubusercontent.com/u/18123323?v=4?s=100" width="100px;" alt=""/><br /><sub><b>rushilgala</b></sub></a><br /><a href="https://github.com/ilkilabs/agorakube/commits?author=rushilgala" title="Code">💻</a></td>
    <td align="center"><a href="https://github.com/tyb3n"><img src="https://avatars.githubusercontent.com/u/16243465?v=4?s=100" width="100px;" alt=""/><br /><sub><b>tyb3n</b></sub></a><br /><a href="https://github.com/ilkilabs/agorakube/commits?author=tyb3n" title="Documentation">📖</a></td>
    <td align="center"><a href="https://ericstumbo.tech"><img src="https://avatars.githubusercontent.com/u/25944964?v=4?s=100" width="100px;" alt=""/><br /><sub><b>Eric Stumbo</b></sub></a><br /><a href="https://github.com/ilkilabs/agorakube/commits?author=digikin" title="Code">💻</a></td>
    <td align="center"><a href="https://github.com/msouvatdy"><img src="https://avatars.githubusercontent.com/u/49560112?v=4?s=100" width="100px;" alt=""/><br /><sub><b>msouvatdy</b></sub></a><br /><a href="https://github.com/ilkilabs/agorakube/commits?author=msouvatdy" title="Code">💻</a> <a href="https://github.com/ilkilabs/agorakube/commits?author=msouvatdy" title="Documentation">📖</a></td>
  </tr>
</table>

<!-- markdownlint-restore -->
<!-- prettier-ignore-end -->

<!-- ALL-CONTRIBUTORS-LIST:END -->

This project follows the [all-contributors](https://github.com/all-contributors/all-contributors) specification. Contributions of any kind welcome!
