#!/bin/bash
    # Determine OS platform
    UNAME=$(uname | tr "[:upper:]" "[:lower:]")
    # If Linux, try to determine specific distribution
    if [ "$UNAME" == "linux" ]; then
        # If available, use LSB to identify distribution
        if [ -f /etc/lsb-release -o -d /etc/lsb-release.d ]; then
            DISTRO=$(lsb_release -i | cut -d: -f2 | sed s/'^\t'//)
        # Otherwise, use release info file
        else
            DISTRO=$(ls -d /etc/[A-Za-z]*[_-][rv]e[lr]* | grep -v "lsb" | cut -d'/' -f3 | cut -d'-' -f1 | cut -d'_' -f1)
        fi
        export DISTRO="${DISTRO,,}"
    fi
    # For everything else (or if above failed), just use generic identifier
    [ "$DISTRO" == "" ] && export DISTRO=$UNAME
    unset UNAME
    echo "#$DISTRO#"
    if [[ $DISTRO == centos* ]]; then
        sudo killall -9 yum
        sudo yum install python -y
        sudo yum install openssh-server -y
    elif [[ $DISTRO == ubuntu* ]] || [[ $DISTRO == debian* ]]; then
        export DEBIAN_FRONTEND=noninteractive
        sudo killall apt apt-get
        sudo apt-get update
        sudo apt-get install -yqq software-properties-common
        sudo apt-get install -yqq openssh-server
        sudo apt-get install -yqq python
    else
        echo "Unsupported OS"
        exit
    fi
