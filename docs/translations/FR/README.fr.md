# AgoraKube
[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)
[![FOSSA Status](https://app.fossa.com/api/projects/git%2Bgithub.com%2Filkilab%2Fagorakube.svg?type=shield)](https://app.fossa.com/projects/git%2Bgithub.com%2Filkilab%2Fagorakube?ref=badge_shield)
[![CII Best Practices](https://bestpractices.coreinfrastructure.org/projects/3104/badge)](https://bestpractices.coreinfrastructure.org/projects/3104)
[![Build Status](https://travis-ci.org/ilkilab/agorakube.svg?branch=master)](https://travis-ci.org/ilkilab/agorakube)

<p align="center">
<img src="../../../images/agorakube-logo.svg" width="450" alt="Agorakube" title="Agorakube" />
</p>
<p>
<img src="https://raw.githubusercontent.com/cncf/artwork/master/projects/kubernetes/certified-kubernetes/versionless/color/certified-kubernetes-color.svg?sanitize=true" width="100" alt="k8s-conformance-v1.16" title="https://github.com/cncf/k8s-conformance/tree/master/v1.16/agorakube"/>
<img src="https://raw.githubusercontent.com/cncf/artwork/master/other/cncf-landscape/stacked/color/cncf-landscape-stacked-color.svg?sanitize=true" width="100" alt="Agorakube is a cncf landscap project" title="Agorakube is a cncf landscap project"/>
</p>
Ce projet vise à fournir le moyen le plus simple d’installer des Clusters kubernetes sur des environnements bare-metal, virtuels et cloud.
Actuellement, Ubuntu 18.04 (Bionic) amd64, debian buster et Centos 7/8 sont pris en charge, mais plusieurs autres systèmes d’exploitation seront bientôt disponibles.

La branche Master est stable.

Lisez la documentation en [Anglais](https://github.com/ilkilab/agorakube/blob/master/README.md)

Depuis novembre 2019, Agorakube est certifié par le "Kubernetes Conformance Program" et est un projet membre du [cncf landscape](https://landscape.cncf.io/selected=agora-kube).

[![asciicast](https://asciinema.org/a/Y58GrrJG3gPM6GvKsSMCZevbX.svg)](https://asciinema.org/a/Y58GrrJG3gPM6GvKsSMCZevbX)

## Table des matières

Voici une liste des points présentés dans ce fichier Readme pour le projet Agorakube:

- [Qu'est-ce qu'Agorakube](#quest-ce-quagorakube)
- [Comment l'installer](#comment-linstaller)
- [Comment nous faire des retours](#comment-nous-faire-des-retours)
- [Comment contribuer](#comment-contribuer)
- [Communauté](#communauté)
- [Licences](#licences)

## Qu'est-ce qu'Agorakube

Agorakube est une distribution Kubernetes stable et simple d'utilisation (Kubernetes v1.15, 1.16, 1.17).

De par sa simplicité, Agorakube offre un bon moyen de déployer et manager des clusters Kubernetes.

Agorakube est basé sur des scripts Ansible qui installent et configurent les composants de Kubernetes (plan de contrôle et plan de données) rapidement en bare-metal / sur des machines virtuelles / sur des instances cloud en tant que services systemd.

Cette distribution vise également à être adaptable en offrant la  possibilité de customiser votre déploiement pour répondre à vos besoins : OS (par défaut : Ubuntu 18.04 (Bionic) - amd64), service DNS (par défaut : CoreDNS), Ingress Controller (par défaut : Traefik), Moteur de container (par défaut : Containerd), certificats, Service-Mesh (disponible: Linkerd),...

Ce projet est en cours de développement et d'autres options de customisation seront bientôt disponibles.

## Comment l'installer

Nous utilisons habituellement une machine virtuelle pour déployer chaque cluster. Elle ne sert qu'au déploiement et à l'administration du cluster.

### Mise en place

#### Sur le noeud de "déploiement"
Exécutez cette commande afin d'installer Ansible et de cloner le dépôt du projet :
```
bash <(curl -s https://raw.githubusercontent.com/ilkilab/agorakube/master/setup-deploy.sh)
```
#### Sur les noeuds K8S
Exécutez cette commande sur chaque noeud pour les mettre à jour et installer la dernière version de Python :
```
bash <(curl -s https://raw.githubusercontent.com/ilkilab/agorakube/master/setup-hosts.sh)
```

### Guide d'installation

Pour déployer votre cluster K8S, suivez ces [instructions](../../instructions.md).

## Comment nous faire des retours

Tous les retours d'expérience sont les bienvenus via la [page GitHub](https://github.com/ilkilab/agorakube) en tant qu'issue ou pull request.

Vous pouvez également remonter les failles de sécurité par ces moyens.

## Comment contribuer

Voir le [Code Of Conduct](https://github.com/ilkilab/agorakube/blob/master/CODE_OF_CONDUCT.md) et [CONTRIBUTING](https://github.com/ilkilab/agorakube/blob/master/docs/CONTRIBUTING.md) pour plus d'informations.

## Communauté

Rejoignez la communauté Agorakube pour discuter et poser des questions : [Agorakube Slack](http://slack.agorakube.ilkilabs.io/)

Channels :
- **#general** - Pour usage  général (news, events...)
- **#developpers** - Pour les contributeurs d'Agorakube qui développent de nouvelles fonctionnalités
- **#end-users** - Pour les utilisateurs qui souhaitent donner leur avis
- **#random** - Comme le nom l'indique, pour discuter de tout et de rien :)

## Licences

Tout le contenu présent est délivré sous la [licence APACHE 2.0 ](../../../LICENSE).
Tout contenu non exécutable, incluant tout texte quand il n'est pas exécuté est également délivré sous la licence APACHE 2.0.
En termes SPDX, tout le contenu est sous licence APACHE 2.0;
si ce contenu n'est pas exécutable, incluant le texte extrait du code, c'est "(APACHE 2.0)".

Comme presque tout logiciel aujourd'hui, ce logiciel dépend d'autres composants ayant leurs propres licences. Les composants donc nous dépendont ne sont pas tous sous licence APACHE 2.0, mais tous les composants *requis* sont sous licence de type FLOSS. Nous prévenons les problèmes de licence à l'aide de différent processus (voir [Contribuer](../../CONTRIBUTING.md))

[![FOSSA Status](https://app.fossa.io/api/projects/git%2Bgithub.com%2Filkilab%2Fagorakube.svg?type=large)](https://app.fossa.io/projects/git%2Bgithub.com%2Filkilab%2Fagorakube?ref=badge_large)
