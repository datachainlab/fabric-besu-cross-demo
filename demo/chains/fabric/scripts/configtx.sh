#!/usr/bin/env bash

set -eu

createChannelTx() {
    PROFILE=$1
    CHANNEL_NAME=$2

    configtxgen \
    -profile "${PROFILE}" \
    -channelID "${CHANNEL_NAME}" \
    -outputCreateChannelTx ./artifacts/"${CHANNEL_NAME}".tx
}

createAnchorPeerTx() {
    PROFILE=$1
    CHANNEL_NAME=$2
    ORG_NAME=$3

	configtxgen \
    -profile "${PROFILE}" \
    -channelID "${CHANNEL_NAME}" \
    -outputAnchorPeersUpdate ./artifacts/"${CHANNEL_NAME}"-"${ORG_NAME}"Anchors.tx \
    -asOrg "${ORG_NAME}"
}

configtxgen \
-profile OrdererGenesis \
-channelID system-channel \
-outputBlock ./artifacts/orderer.block \
-asOrg OrdererOrg

createChannelTx ERC20Channel erc20-channel Platformer

createAnchorPeerTx ERC20Channel erc20-channel Platformer
createAnchorPeerTx ERC20Channel erc20-channel OrgA
createAnchorPeerTx ERC20Channel erc20-channel OrgB
