BESU_VERSION ?= 21.10
BESU ?= docker run --rm -v ${CURDIR}/networkFiles:/tmp/besu/networkFiles -v ${CURDIR}/ibftConfigFile.json:/tmp/besu/ibftConfigFile.json -u root hyperledger/besu:${BESU_VERSION}

.PHONY: generate-blockchain-config
generate-blockchain-config:
	rm -rf ${CURDIR}/networkFiles
	$(BESU) operator generate-blockchain-config --config-file=/tmp/besu/ibftConfigFile.json --to=/tmp/besu/networkFiles --private-key-file-name=key

.PHONY: network
network: generate-blockchain-config
	BESU_VERSION=${BESU_VERSION} docker compose up -d --build
	make -C ../../../contracts/erc721 truffle-migrate-demo

.PHONY: network-down
network-down:
	docker compose down -v --remove-orphans

.PHONY: clean
clean:
	rm -rf networkFiles
