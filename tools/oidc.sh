#!/bin/bash

KEYCLOAK_URL=https://oidc.local.lan
KEYCLOAK_REALM=local
KEYCLOAK_CLIENT_ID=kube
KEYCLOAK_CLIENT_SECRET=79e34f70-581a-4cc3-a2b4-10b5a4d670df
KEYCLOAK_CA_CRT=/var/agorakube/pki/oidc/oidc-ca.crt

cat <<EOF
#####################################################################
#                                                                   #
#   WARNINGS:                                                       #
#                                                                   #
#   THIS  SCRIPT NEEDS PACKAGE 'jq' INSTALLED                       #
#      On Centos/Fedora : yum update && yum install -y jq           #
#      On Ubuntu/Debian : apt update && apt install -y jq           #
#                                                                   #
#####################################################################
#
#  CURRENT CONFIG:
#    KEYCLOAK_URL           = ${KEYCLOAK_URL}
#    KEYCLOAK_REALM         = ${KEYCLOAK_REALM}
#    KEYCLOAK_CLIENT_ID     = ${KEYCLOAK_CLIENT_ID}
#    KEYCLOAK_CLIENT_SECRET = ${KEYCLOAK_CLIENT_SECRET}
#    KEYCLOAK_CA_CRT        = ${KEYCLOAK_CA_CRT}
#
#####################################################################
EOF

KEYCLOAK_USERNAME=$1
KEYCLOAK_PASSWORD=$2



if [ "${KEYCLOAK_USERNAME}" = "" ];then
        read -p "username: " KEYCLOAK_USERNAME
fi
if [ "${KEYCLOAK_PASSWORD}" = "" ];then
        read -sp "password: " KEYCLOAK_PASSWORD
fi

KEYCLOAK_TOKEN_URL=${KEYCLOAK_URL}/auth/realms/${KEYCLOAK_REALM}/protocol/openid-connect/token

echo
echo "# Getting a token ..."

TOKEN=`curl -k -s ${KEYCLOAK_TOKEN_URL} \
  -d grant_type=password \
  -d response_type=id_token \
  -d scope=openid \
  -d client_id=${KEYCLOAK_CLIENT_ID} \
  -d client_secret=${KEYCLOAK_CLIENT_SECRET} \
  -d username=${KEYCLOAK_USERNAME} \
  -d password=${KEYCLOAK_PASSWORD}`

RET=$?
if [ "$RET" != "0" ];then
        echo "# Error ($RET) ==> ${TOKEN}";
        exit ${RET}
fi

ERROR=`echo ${TOKEN} | jq .error -r`
if [ "${ERROR}" != "null" ];then
        echo "# Failed ==> ${TOKEN}" >&2
        exit 1
fi

ID_TOKEN=`echo ${TOKEN} | jq .id_token -r`
REFRESH_TOKEN=`echo ${TOKEN} | jq .refresh_token -r`


cat <<EOF

#####################################################################################################
#  ADD YOUR USER ${KEYCLOAK_USERNAME} TO YOUR CURRENT KUBECONFIG FILE WITH THE FOLLOWING COMMAND:
#####################################################################################################

kubectl config set-credentials ${KEYCLOAK_USERNAME} \\
   --auth-provider=oidc \\
   --auth-provider-arg=idp-issuer-url=${KEYCLOAK_URL}/auth/realms/${KEYCLOAK_REALM} \\
   --auth-provider-arg=client-id=${KEYCLOAK_CLIENT_ID} \\
   --auth-provider-arg=client-secret=${KEYCLOAK_CLIENT_SECRET} \\
   --auth-provider-arg=refresh-token=${REFRESH_TOKEN} \\
   --auth-provider-arg=idp-certificate-authority=${KEYCLOAK_CA_CRT} \\
   --auth-provider-arg=id-token=${ID_TOKEN}

#####################################################################################################
#  SET YOUR CURRENT CONTEXT TO USE ${KEYCLOAK_USERNAME} USER WITH THE FOLLOWING COMMAND:
#####################################################################################################

kubectl config set-context $(kubectl config current-context) --user=${KEYCLOAK_USERNAME}

########################################################################
#  ALTERNATIVE WAY TO ADD ${KEYCLOAK_USERNAME} TO YOUR KUBECONFIG FILE #
########################################################################

# Add the following bloc to your \`users:\` in ~/.kube/config

--------------------------------------------------------------------------------------

- name: ${KEYCLOAK_USERNAME}
  user:
    auth-provider:
      name: oidc
      config:
        client-id: ${KEYCLOAK_CLIENT_ID}
        client-secret: ${KEYCLOAK_CLIENT_SECRET}
        idp-issuer-url: ${KEYCLOAK_URL}/auth/realms/${KEYCLOAK_REALM}
        id-token: ${ID_TOKEN}
        refresh-token: ${REFRESH_TOKEN}
        idp-certificate-authority: ${KEYCLOAK_CA_CRT}

---------------------------------------------------------------------------------------

# Edit your \`contexts:\` in ~/.kube/config to indicate to kubectl to use your user ${KEYCLOAK_USERNAME}



#################
#  END SCRIPT   #
#################

EOF
