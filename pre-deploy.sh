#!/bin/bash -e

APP_NAME=$1
ENV=$2

if [[ -n ${GO_SCM_COMMON_SERVICES_SKELETON_GIT_PR_BRANCH} ]]
then
  GIT_BRANCH=${GO_SCM_COMMON_SERVICES_SKELETON_GIT_PR_BRANCH#atgse:}
else
  GIT_BRANCH=master
fi

oc delete secret ${APP_NAME} -n ${ENV} ||: 

oc create secret generic ${APP_NAME} \
	        --from-literal=KEYSTORE_PASSWORD=changeit \
	        --from-literal=PASSWORD=helloworldpass \
		--from-literal=JAVA_OPTIONS="-Djavax.net.ssl.trustStore=/var/run/secrets/java.io/keystores/truststore.jks -Djavax.net.ssl.trustStorePassword=changeit" \
		-n ${ENV}

oc delete configmap ${APP_NAME} -n ${ENV} ||:

oc create configmap ${APP_NAME} --from-literal=VAULT_HOST=vault-vault.ocptest.hh.atg.se --from-literal=VAULT_PORT=443 --from-literal=SPRING_CLOUD_VAULT_ENABLED=false  -n ${ENV}

oc new-app --template=oracle-xe-template -p GIT_URL="git@github.com:atgse/common-services-skeleton" -p APP_NAME=${APP_NAME} -p GIT_BRANCH=${GIT_BRANCH} -p GIT_TAG=branch -p SRC_DIR=db-test -n ${ENV}
