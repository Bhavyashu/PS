#!/bin/bash

function one_line_pem {
    echo "`awk 'NF {sub(/\\n/, ""); printf "%s\\\\\\\n",$0;}' $1`"
}

function json_ccp {
    local PP=$(one_line_pem $6)
    local CP=$(one_line_pem $7)
    sed -e "s/\${ORG}/$1/" \
        -e "s/\${P0PORT}/$2/" \
        -e "s/\${P1PORT}/$3/" \
        -e "s/\${P2PORT}/$4/" \
        -e "s/\${CAPORT}/$5/" \
        -e "s#\${PEERPEM}#$PP#" \
        -e "s#\${CAPEM}#$CP#" \
        organizations/ccp-template.json
}

function yaml_ccp {
    local PP=$(one_line_pem $6)
    local CP=$(one_line_pem $7)
    sed -e "s/\${ORG}/$1/" \
        -e "s/\${P0PORT}/$2/" \
        -e "s/\${P1PORT}/$3/" \
        -e "s/\${P2PORT}/$4/" \
        -e "s/\${CAPORT}/$5/" \
        -e "s#\${PEERPEM}#$PP#" \
        -e "s#\${CAPEM}#$CP#" \
        organizations/ccp-template.yaml | sed -e $'s/\\\\n/\\\n          /g'
}

## prepare connection profile for orgowner
ORG=owner
P0PORT=4444
P1PORT=4454
P2PORT=4464
CAPORT=4400
PEERPEM=organizations/peerOrganizations/owner/tlsca/tlsca.owner-cert.pem
CAPEM=organizations/peerOrganizations/owner/ca/ca.owner-cert.pem

echo "$(json_ccp $ORG $P0PORT $P1PORT $P2PORT $CAPORT $PEERPEM $CAPEM)" > organizations/peerOrganizations/owner/connection-owner.json
echo "$(yaml_ccp $ORG $P0PORT $P1PORT $P2PORT $CAPORT $PEERPEM $CAPEM)" > organizations/peerOrganizations/owner/connection-owner.yaml
# save another copy of json connection profile in a different directory
echo "$(json_ccp $ORG $P0PORT $P1PORT $P2PORT $CAPORT $PEERPEM $CAPEM)" > network-config/network-config-owner.json

## prepare connection profile for orgseller
ORG=seller
P0PORT=5555
P1PORT=5565
P2PORT=5575
CAPORT=5500
PEERPEM=organizations/peerOrganizations/seller/tlsca/tlsca.seller-cert.pem
CAPEM=organizations/peerOrganizations/seller/ca/ca.seller-cert.pem

echo "$(json_ccp $ORG $P0PORT $P1PORT $P2PORT $CAPORT $PEERPEM $CAPEM)" > organizations/peerOrganizations/seller/connection-seller.json
echo "$(yaml_ccp $ORG $P0PORT $P1PORT $P2PORT $CAPORT $PEERPEM $CAPEM)" > organizations/peerOrganizations/seller/connection-seller.yaml
# save another copy of json connection profile in a different directory
echo "$(json_ccp $ORG $P0PORT $P1PORT $P2PORT $CAPORT $PEERPEM $CAPEM)" > network-config/network-config-seller.json




