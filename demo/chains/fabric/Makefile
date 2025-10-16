include ../../var.mk

FABRIC_BIN_DIR ?= ${CURDIR}/.bin
export PATH := ${FABRIC_BIN_DIR}:${PATH}
export FABRIC_CFG_PATH=${CURDIR}/configtx

SCRIPT_DIR ?= ${CURDIR}/scripts

.PHONY: network
network:
	make cryptogen
	make configtx
	make network-common
	make channel
	make chaincode
	make network-chaincode

.PHONY: network-common
network-common:
	FABRIC_PLATFORM=${FABRIC_PLATFORM} IMAGE_TAG=${FABRIC_VERSION} ${DOCKER_COMPOSE} up -d \
	fabric-orderer.fabric-besu-cross-demo.com \
	fabric-peer0.platformer.fabric-besu-cross-demo.com \
	fabric-peer0.orga.fabric-besu-cross-demo.com \
	fabric-peer0.orgb.fabric-besu-cross-demo.com

.PHONY: network-chaincode
network-chaincode:
	FABRIC_PLATFORM=${FABRIC_PLATFORM} IMAGE_TAG=${FABRIC_VERSION} ${DOCKER_COMPOSE} up -d \
	fabric-chaincode.platformer.fabric-besu-cross-demo.com \
	fabric-chaincode.orga.fabric-besu-cross-demo.com \
	fabric-chaincode.orgb.fabric-besu-cross-demo.com

.PHONY: network-down
network-down:
	FABRIC_PLATFORM=${FABRIC_PLATFORM} IMAGE_TAG=${FABRIC_VERSION} ${DOCKER_COMPOSE} down -v --remove-orphans

.PHONY: clean
clean:
	rm -rf artifacts
	rm -rf backup
	rm -rf build
	rm -rf ${CURDIR}/external-builders/config/**/code.tar.gz
	rm -rf organizations

.PHONY: bin
bin:
	rm -rf ${CURDIR}/.bin
	curl -sSL https://bit.ly/2ysbOFE | bash -s -- ${FABRIC_VERSION} ${FABRIC_CA_VERSION} -d -s
	rm -rf ${CURDIR}/config
	mv ${CURDIR}/bin ${CURDIR}/.bin

.PHONY: cryptogen
cryptogen:
	${FABRIC_BIN_DIR}/cryptogen generate --config ${CURDIR}/cryptogen/crypto-config.yaml --output ./organizations

.PHONY: configtx
configtx:
	${SCRIPT_DIR}/configtx.sh

.PHONY: channel
channel:
	${SCRIPT_DIR}/createChannel.sh

.PHONY: chaincode
chaincode:
	${SCRIPT_DIR}/deployCC.sh

.PHONY: docker-chaincode
docker-chaincode:
	cd chaincode/fabibc && go mod vendor
	${DOCKER_BUILD} --tag fabric-chaincode-fabibc:latest ./chaincode/fabibc
