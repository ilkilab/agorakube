#!/bin/bash
if which ansible-playbook >/dev/null; then
  echo "Ansible is already installed"
else

    # Determine OS platform
    UNAME=$(uname | tr "[:upper:]" "[:lower:]")
    # If Linux, try to determine specific distribution
    if [ "$UNAME" == "linux" ]; then
        # If available, use LSB to identify distribution
        if [ -f /etc/lsb-release -o -d /etc/lsb-release.d ]; then
            export DISTRO=$(lsb_release -i | cut -d: -f2 | sed s/'^\t'//)
        # Otherwise, use release info file
        else
            export DISTRO=$(ls -d /etc/[A-Za-z]*[_-][rv]e[lr]* | grep -v "lsb" | cut -d'/' -f3 | cut -d'-' -f1 | cut -d'_' -f1)
        fi
    fi
    # For everything else (or if above failed), just use generic identifier
    [ "$DISTRO" == "" ] && export DISTRO=$UNAME
    unset UNAME
    echo "#$DISTRO#"
    if [[ $DISTRO == centos* ]]; then
        killall -9 yum
        yum install epel-release -y
        yum install ansible -y
    elif [[ $DISTRO == Ubuntu* ]]; then
        export DEBIAN_FRONTEND=noninteractive
        apt-get update
        apt-get install -yqq git software-properties-common
        apt-add-repository --yes --update ppa:ansible/ansible
        apt-get install -yqq ansible
        add-apt-repository --yes --remove ppa:PPA_Name/ppa
    else
        echo "Unsupported Vagrant box"
        exit
    fi
fi
cd /agorakube
ansible-playbook -i test_lab/hosts.vagrant agorakube.yaml
if [ -f /root/agorakube-info.txt ]; then
  cat /root/agorakube-info.txt
fi

