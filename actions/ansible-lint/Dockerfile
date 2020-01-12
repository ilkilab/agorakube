FROM ubuntu:18.04
MAINTAINER Ilkilabs @ www.ilki.fr
RUN apt update
RUN apt install software-properties-common -yqq
RUN apt-add-repository --yes --update ppa:ansible/ansible
RUN apt install ansible -yqq
RUN apt install python-pip git -yqq
RUN pip install ansible-lint
ENTRYPOINT ["/usr/local/bin/ansible-lint"]
CMD ["-c","ansible-lint.conf"]
