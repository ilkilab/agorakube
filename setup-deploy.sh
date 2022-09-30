#!/bin/bash
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
DISTRO=$(echo $DISTRO | tr '[:upper:]' '[:lower:]')
#echo $DISTRO

if [[ $DISTRO == *"ubuntu"* ]]; then
  export DEBIAN_FRONTEND=noninteractive
  sudo killall apt apt-get
  sudo apt update
  sudo apt install software-properties-common curl git openssh-server -yqq
  sudo apt -y install python3 python3-pip
  sudo pip3 install ansible
  sudo pip3 install netaddr
  git clone https://github.com/ilkilab/agorakube.git -b minimal/master

elif [[ $DISTRO == *"centos"* ]]; then
  sudo killall -9 yum
  sudo yum update -y && sudo yum install -y curl openssh-server git
  sudo yum -y --enablerepo=extras install epel-release
  sudo yum -y install python python-pip libselinux-python python-netaddr
  sudo pip install ansible
  sudo pip install netaddr
  git clone https://github.com/ilkilab/agorakube.git -b minimal/master

elif [[ $DISTRO == *"debian"* ]]; then
  export DEBIAN_FRONTEND=noninteractive
  sudo killall apt apt-get
  sudo apt update
  sudo apt install software-properties-common curl git openssh-server -yqq
  sudo apt -y install python3 python3-pip
  sudo pip3 install ansible
  sudo pip3 install netaddr
  git clone https://github.com/ilkilab/agorakube.git -b minimal/master

else
        echo "Unsupported OS"
        exit
fi
