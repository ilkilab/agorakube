FROM agorakube/ansible-lint:v1
MAINTAINER Ilkilabs @ www.ilki.fr
COPY ./entrypoint.sh /bin/entrypoint.sh
RUN chmod +x /bin/entrypoint.sh
COPY ./lint-config/ /var/
CMD ["/bin/entrypoint.sh"]
