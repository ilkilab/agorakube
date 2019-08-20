# AgoraKube

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)
[![FOSSA Status](https://app.fossa.com/api/projects/git%2Bgithub.com%2Filkilab%2Fagorakube.svg?type=shield)](https://app.fossa.com/projects/git%2Bgithub.com%2Filkilab%2Fagorakube?ref=badge_shield)
[![CII Best Practices](https://bestpractices.coreinfrastructure.org/projects/3104/badge)](https://bestpractices.coreinfrastructure.org/projects/3104)



This project is aimed to provide the simplest way to install kubernetes on bare-metal systems.
Actually, only Ubuntu 18.04 (Bionic) amd64 is supported, but many other systems will be available soon.


This project is still under development. 
Feedback is very welcome via the
[GitHub site](https://github.com/ilkilab/agorakube)
as issues or pull (merge) requests.



## Summary

This is a list of points that will be explained in this Readme file for the AgoraKube project :

- What is AgoraKube
- How to get it
- How to give feedback
- How to contribute
- Licence

## What is AgoraKube

AgoraKube is an easy-to-use, stable Kubernetes distribution (Kubernetes v1.15)

By its symplicity, AgoraKube provide a good way to deploy and manage K8S CLusters.

AgoraKube is based on Ansible scripts that install and configure Kubernetes componants (control plane and data plane) quickly on bare-metal / VMs / Cloud Instances, as systemd services.

Many options are customizable, like DNS Service (default: CoreDNS), Ingress (default: Traefik), Runtime (Default: Containerd), certificats,...

This project is actually under development, ans only Ubuntu 18.04 (Bionic) - amd64 system is syported. Other systems will be added soon.

## How to get it

### On the Deploy machine
```
bash <(curl -s https://raw.githubusercontent.com/ilkilab/agorakube/master/install.sh)
```
### On the nodes machines
```
sudo apt update && sudo apt install -yqq python
```

### Install instructions

See [instructions](docs/instructions.md) for more details

## How to give feedback

This project is still under development. 
Feedback is very welcome via the
[GitHub site](https://github.com/ilkilab/agorakube)
as issues or pull (merge) requests.

You can also give use vulnerability reports by this way.
## How to contribute

This project is still under development. 
Contributions are very welcome via the
[GitHub site](https://github.com/ilkilab/agorakube)
as issues or pull (merge) requests.

See our [Code Of Conduct](https://github.com/ilkilab/agorakube/blob/master/CODE_OF_CONDUCT.md) and [CONTRIBUTING](https://github.com/ilkilab/agorakube/blob/master/docs/CONTRIBUTING.md) for more information.

## License

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


[![FOSSA Status](https://app.fossa.io/api/projects/git%2Bgithub.com%2Fpierreilki%2FIlkiKube.svg?type=large)](https://app.fossa.io/projects/git%2Bgithub.com%2Fpierreilki%2FIlkiKube?ref=badge_large)
