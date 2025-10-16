#!/usr/bin/env bash
set -eu pipefail

SCRIPT_DIR=$(cd $(dirname $0);pwd)
PROJECT_DIR=$SCRIPT_DIR/..

CHAINCODE_CCID_PLATFORMER=$(cat ${PROJECT_DIR}/build/Platformer-fabibc-ccid.txt)
CHAINCODE_CCID_ORGA=$(cat ${PROJECT_DIR}/build/OrgA-fabibc-ccid.txt)
CHAINCODE_CCID_ORGB=$(cat ${PROJECT_DIR}/build/OrgB-fabibc-ccid.txt)

set -x
CHAINCODE_CCID_PLATFORMER=${CHAINCODE_CCID_PLATFORMER} \
CHAINCODE_CCID_ORGA=${CHAINCODE_CCID_ORGA} \
CHAINCODE_CCID_ORGB=${CHAINCODE_CCID_ORGB} \
docker compose -f docker-compose-chaincode.yaml up -d \
