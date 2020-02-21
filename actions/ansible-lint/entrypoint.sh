#!/bin/bash

if [ -f /var/ansible-lint.conf ]; then
   /usr/local/bin/ansible-lint -c /var/ansible-lint.conf
else
  /usr/local/bin/ansible-lint
fi
