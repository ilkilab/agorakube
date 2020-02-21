FROM ubuntu:18.04
MAINTAINER Ilkilabs @ www.ilki.fr
RUN apt update && apt install software-properties-common -yqq
RUN apt-add-repository --yes --update ppa:ansible/ansible
RUN apt install ansible python-pip git -yqq
RUN pip install ansible-lint
CMD ["/bin/bash"]
