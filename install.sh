#!/bin/bash
sudo apt update
sudo apt install -yqq git software-properties-common
sudo apt-add-repository --yes --update ppa:ansible/ansible
sudo apt install -yqq ansible
git clone https://github.com/ilkilab/agorakube.git
