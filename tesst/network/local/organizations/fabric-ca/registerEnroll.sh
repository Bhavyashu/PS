#!/bin/bash

function createowner() {
  infoln "Enrolling the CA admin"
  mkdir -p organizations/peerOrganizations/owner/

  export FABRIC_CA_CLIENT_HOME=${PWD}/organizations/peerOrganizations/owner/


  fabric-ca-client enroll -u https://admin:adminpw@localhost:4400 --caname ca-owner --tls.certfiles ${PWD}/organizations/fabric-ca/owner/tls-cert.pem


  echo 'NodeOUs:
  Enable: true
  ClientOUIdentifier:
    Certificate: cacerts/localhost-4400-ca-owner.pem
    OrganizationalUnitIdentifier: client
  PeerOUIdentifier:
    Certificate: cacerts/localhost-4400-ca-owner.pem
    OrganizationalUnitIdentifier: peer
  AdminOUIdentifier:
    Certificate: cacerts/localhost-4400-ca-owner.pem
    OrganizationalUnitIdentifier: admin
  OrdererOUIdentifier:
    Certificate: cacerts/localhost-4400-ca-owner.pem
    OrganizationalUnitIdentifier: orderer' >${PWD}/organizations/peerOrganizations/owner/msp/config.yaml

  infoln "Registering peer0"

  fabric-ca-client register --caname ca-owner --id.name peer0 --id.secret peer0pw --id.type peer --tls.certfiles ${PWD}/organizations/fabric-ca/owner/tls-cert.pem


  infoln "Registering peer1"

  fabric-ca-client register --caname ca-owner --id.name peer1 --id.secret peer1pw --id.type peer --tls.certfiles ${PWD}/organizations/fabric-ca/owner/tls-cert.pem


  infoln "Registering peer2"

  fabric-ca-client register --caname ca-owner --id.name peer2 --id.secret peer2pw --id.type peer --tls.certfiles ${PWD}/organizations/fabric-ca/owner/tls-cert.pem


  infoln "Registering user"

  fabric-ca-client register --caname ca-owner --id.name user1 --id.secret user1pw --id.type client --tls.certfiles ${PWD}/organizations/fabric-ca/owner/tls-cert.pem


  infoln "Registering the org admin"

  fabric-ca-client register --caname ca-owner --id.name owneradmin --id.secret owneradminpw --id.type admin --tls.certfiles ${PWD}/organizations/fabric-ca/owner/tls-cert.pem


  infoln "Generating the peer0 msp"

  fabric-ca-client enroll -u https://peer0:peer0pw@localhost:4400 --caname ca-owner -M ${PWD}/organizations/peerOrganizations/owner/peers/peer0.owner/msp --csr.hosts peer0.owner --tls.certfiles ${PWD}/organizations/fabric-ca/owner/tls-cert.pem


  infoln "Generating the peer1 msp"

  fabric-ca-client enroll -u https://peer1:peer1pw@localhost:4400 --caname ca-owner -M ${PWD}/organizations/peerOrganizations/owner/peers/peer1.owner/msp --csr.hosts peer1.owner --tls.certfiles ${PWD}/organizations/fabric-ca/owner/tls-cert.pem


  infoln "Generating the peer2 msp"

  fabric-ca-client enroll -u https://peer2:peer2pw@localhost:4400 --caname ca-owner -M ${PWD}/organizations/peerOrganizations/owner/peers/peer2.owner/msp --csr.hosts peer2.owner --tls.certfiles ${PWD}/organizations/fabric-ca/owner/tls-cert.pem


  cp ${PWD}/organizations/peerOrganizations/owner/msp/config.yaml ${PWD}/organizations/peerOrganizations/owner/peers/peer0.owner/msp/config.yaml
  cp ${PWD}/organizations/peerOrganizations/owner/msp/config.yaml ${PWD}/organizations/peerOrganizations/owner/peers/peer1.owner/msp/config.yaml
  cp ${PWD}/organizations/peerOrganizations/owner/msp/config.yaml ${PWD}/organizations/peerOrganizations/owner/peers/peer2.owner/msp/config.yaml

  infoln "Generating the peer0-tls certificates"
  fabric-ca-client enroll -u https://peer0:peer0pw@localhost:4400 --caname ca-owner -M ${PWD}/organizations/peerOrganizations/owner/peers/peer0.owner/tls --enrollment.profile tls --csr.hosts peer0.owner --csr.hosts localhost --tls.certfiles ${PWD}/organizations/fabric-ca/owner/tls-cert.pem

  infoln "Generating the peer1-tls certificates"
  fabric-ca-client enroll -u https://peer1:peer1pw@localhost:4400 --caname ca-owner -M ${PWD}/organizations/peerOrganizations/owner/peers/peer1.owner/tls --enrollment.profile tls --csr.hosts peer1.owner --csr.hosts localhost --tls.certfiles ${PWD}/organizations/fabric-ca/owner/tls-cert.pem

  infoln "Generating the peer2-tls certificates"
  fabric-ca-client enroll -u https://peer2:peer2pw@localhost:4400 --caname ca-owner -M ${PWD}/organizations/peerOrganizations/owner/peers/peer2.owner/tls --enrollment.profile tls --csr.hosts peer2.owner --csr.hosts localhost --tls.certfiles ${PWD}/organizations/fabric-ca/owner/tls-cert.pem

  cp ${PWD}/organizations/peerOrganizations/owner/peers/peer0.owner/tls/tlscacerts/* ${PWD}/organizations/peerOrganizations/owner/peers/peer0.owner/tls/ca.crt
  cp ${PWD}/organizations/peerOrganizations/owner/peers/peer0.owner/tls/signcerts/* ${PWD}/organizations/peerOrganizations/owner/peers/peer0.owner/tls/server.crt
  cp ${PWD}/organizations/peerOrganizations/owner/peers/peer0.owner/tls/keystore/* ${PWD}/organizations/peerOrganizations/owner/peers/peer0.owner/tls/server.key



  cp ${PWD}/organizations/peerOrganizations/owner/peers/peer1.owner/tls/tlscacerts/* ${PWD}/organizations/peerOrganizations/owner/peers/peer1.owner/tls/ca.crt
  cp ${PWD}/organizations/peerOrganizations/owner/peers/peer1.owner/tls/signcerts/* ${PWD}/organizations/peerOrganizations/owner/peers/peer1.owner/tls/server.crt
  cp ${PWD}/organizations/peerOrganizations/owner/peers/peer1.owner/tls/keystore/* ${PWD}/organizations/peerOrganizations/owner/peers/peer1.owner/tls/server.key



  cp ${PWD}/organizations/peerOrganizations/owner/peers/peer2.owner/tls/tlscacerts/* ${PWD}/organizations/peerOrganizations/owner/peers/peer2.owner/tls/ca.crt
  cp ${PWD}/organizations/peerOrganizations/owner/peers/peer2.owner/tls/signcerts/* ${PWD}/organizations/peerOrganizations/owner/peers/peer2.owner/tls/server.crt
  cp ${PWD}/organizations/peerOrganizations/owner/peers/peer2.owner/tls/keystore/* ${PWD}/organizations/peerOrganizations/owner/peers/peer2.owner/tls/server.key



  mkdir -p ${PWD}/organizations/peerOrganizations/owner/msp/tlscacerts
  cp ${PWD}/organizations/peerOrganizations/owner/peers/peer0.owner/tls/tlscacerts/* ${PWD}/organizations/peerOrganizations/owner/msp/tlscacerts/ca.crt

  mkdir -p ${PWD}/organizations/peerOrganizations/owner/tlsca
  cp ${PWD}/organizations/peerOrganizations/owner/peers/peer0.owner/tls/tlscacerts/* ${PWD}/organizations/peerOrganizations/owner/tlsca/tlsca.owner-cert.pem

  mkdir -p ${PWD}/organizations/peerOrganizations/owner/ca
  cp ${PWD}/organizations/peerOrganizations/owner/peers/peer0.owner/msp/cacerts/* ${PWD}/organizations/peerOrganizations/owner/ca/ca.owner-cert.pem

  infoln "Generating the user msp"

  fabric-ca-client enroll -u https://user1:user1pw@localhost:4400 --caname ca-owner -M ${PWD}/organizations/peerOrganizations/owner/users/User1@owner/msp --tls.certfiles ${PWD}/organizations/fabric-ca/owner/tls-cert.pem


  cp ${PWD}/organizations/peerOrganizations/owner/msp/config.yaml ${PWD}/organizations/peerOrganizations/owner/users/User1@owner/msp/config.yaml

  infoln "Generating the org admin msp"

  fabric-ca-client enroll -u https://owneradmin:owneradminpw@localhost:4400 --caname ca-owner -M ${PWD}/organizations/peerOrganizations/owner/users/Admin@owner/msp --tls.certfiles ${PWD}/organizations/fabric-ca/owner/tls-cert.pem


  cp ${PWD}/organizations/peerOrganizations/owner/msp/config.yaml ${PWD}/organizations/peerOrganizations/owner/users/Admin@owner/msp/config.yaml
}
function createseller() {
  infoln "Enrolling the CA admin"
  mkdir -p organizations/peerOrganizations/seller/

  export FABRIC_CA_CLIENT_HOME=${PWD}/organizations/peerOrganizations/seller/


  fabric-ca-client enroll -u https://admin:adminpw@localhost:5500 --caname ca-seller --tls.certfiles ${PWD}/organizations/fabric-ca/seller/tls-cert.pem


  echo 'NodeOUs:
  Enable: true
  ClientOUIdentifier:
    Certificate: cacerts/localhost-5500-ca-seller.pem
    OrganizationalUnitIdentifier: client
  PeerOUIdentifier:
    Certificate: cacerts/localhost-5500-ca-seller.pem
    OrganizationalUnitIdentifier: peer
  AdminOUIdentifier:
    Certificate: cacerts/localhost-5500-ca-seller.pem
    OrganizationalUnitIdentifier: admin
  OrdererOUIdentifier:
    Certificate: cacerts/localhost-5500-ca-seller.pem
    OrganizationalUnitIdentifier: orderer' >${PWD}/organizations/peerOrganizations/seller/msp/config.yaml

  infoln "Registering peer0"

  fabric-ca-client register --caname ca-seller --id.name peer0 --id.secret peer0pw --id.type peer --tls.certfiles ${PWD}/organizations/fabric-ca/seller/tls-cert.pem


  infoln "Registering peer1"

  fabric-ca-client register --caname ca-seller --id.name peer1 --id.secret peer1pw --id.type peer --tls.certfiles ${PWD}/organizations/fabric-ca/seller/tls-cert.pem


  infoln "Registering peer2"

  fabric-ca-client register --caname ca-seller --id.name peer2 --id.secret peer2pw --id.type peer --tls.certfiles ${PWD}/organizations/fabric-ca/seller/tls-cert.pem


  infoln "Registering user"

  fabric-ca-client register --caname ca-seller --id.name user1 --id.secret user1pw --id.type client --tls.certfiles ${PWD}/organizations/fabric-ca/seller/tls-cert.pem


  infoln "Registering the org admin"

  fabric-ca-client register --caname ca-seller --id.name selleradmin --id.secret selleradminpw --id.type admin --tls.certfiles ${PWD}/organizations/fabric-ca/seller/tls-cert.pem


  infoln "Generating the peer0 msp"

  fabric-ca-client enroll -u https://peer0:peer0pw@localhost:5500 --caname ca-seller -M ${PWD}/organizations/peerOrganizations/seller/peers/peer0.seller/msp --csr.hosts peer0.seller --tls.certfiles ${PWD}/organizations/fabric-ca/seller/tls-cert.pem


  infoln "Generating the peer1 msp"

  fabric-ca-client enroll -u https://peer1:peer1pw@localhost:5500 --caname ca-seller -M ${PWD}/organizations/peerOrganizations/seller/peers/peer1.seller/msp --csr.hosts peer1.seller --tls.certfiles ${PWD}/organizations/fabric-ca/seller/tls-cert.pem


  infoln "Generating the peer2 msp"

  fabric-ca-client enroll -u https://peer2:peer2pw@localhost:5500 --caname ca-seller -M ${PWD}/organizations/peerOrganizations/seller/peers/peer2.seller/msp --csr.hosts peer2.seller --tls.certfiles ${PWD}/organizations/fabric-ca/seller/tls-cert.pem


  cp ${PWD}/organizations/peerOrganizations/seller/msp/config.yaml ${PWD}/organizations/peerOrganizations/seller/peers/peer0.seller/msp/config.yaml
  cp ${PWD}/organizations/peerOrganizations/seller/msp/config.yaml ${PWD}/organizations/peerOrganizations/seller/peers/peer1.seller/msp/config.yaml
  cp ${PWD}/organizations/peerOrganizations/seller/msp/config.yaml ${PWD}/organizations/peerOrganizations/seller/peers/peer2.seller/msp/config.yaml

  infoln "Generating the peer0-tls certificates"
  fabric-ca-client enroll -u https://peer0:peer0pw@localhost:5500 --caname ca-seller -M ${PWD}/organizations/peerOrganizations/seller/peers/peer0.seller/tls --enrollment.profile tls --csr.hosts peer0.seller --csr.hosts localhost --tls.certfiles ${PWD}/organizations/fabric-ca/seller/tls-cert.pem

  infoln "Generating the peer1-tls certificates"
  fabric-ca-client enroll -u https://peer1:peer1pw@localhost:5500 --caname ca-seller -M ${PWD}/organizations/peerOrganizations/seller/peers/peer1.seller/tls --enrollment.profile tls --csr.hosts peer1.seller --csr.hosts localhost --tls.certfiles ${PWD}/organizations/fabric-ca/seller/tls-cert.pem

  infoln "Generating the peer2-tls certificates"
  fabric-ca-client enroll -u https://peer2:peer2pw@localhost:5500 --caname ca-seller -M ${PWD}/organizations/peerOrganizations/seller/peers/peer2.seller/tls --enrollment.profile tls --csr.hosts peer2.seller --csr.hosts localhost --tls.certfiles ${PWD}/organizations/fabric-ca/seller/tls-cert.pem

  cp ${PWD}/organizations/peerOrganizations/seller/peers/peer0.seller/tls/tlscacerts/* ${PWD}/organizations/peerOrganizations/seller/peers/peer0.seller/tls/ca.crt
  cp ${PWD}/organizations/peerOrganizations/seller/peers/peer0.seller/tls/signcerts/* ${PWD}/organizations/peerOrganizations/seller/peers/peer0.seller/tls/server.crt
  cp ${PWD}/organizations/peerOrganizations/seller/peers/peer0.seller/tls/keystore/* ${PWD}/organizations/peerOrganizations/seller/peers/peer0.seller/tls/server.key



  cp ${PWD}/organizations/peerOrganizations/seller/peers/peer1.seller/tls/tlscacerts/* ${PWD}/organizations/peerOrganizations/seller/peers/peer1.seller/tls/ca.crt
  cp ${PWD}/organizations/peerOrganizations/seller/peers/peer1.seller/tls/signcerts/* ${PWD}/organizations/peerOrganizations/seller/peers/peer1.seller/tls/server.crt
  cp ${PWD}/organizations/peerOrganizations/seller/peers/peer1.seller/tls/keystore/* ${PWD}/organizations/peerOrganizations/seller/peers/peer1.seller/tls/server.key



  cp ${PWD}/organizations/peerOrganizations/seller/peers/peer2.seller/tls/tlscacerts/* ${PWD}/organizations/peerOrganizations/seller/peers/peer2.seller/tls/ca.crt
  cp ${PWD}/organizations/peerOrganizations/seller/peers/peer2.seller/tls/signcerts/* ${PWD}/organizations/peerOrganizations/seller/peers/peer2.seller/tls/server.crt
  cp ${PWD}/organizations/peerOrganizations/seller/peers/peer2.seller/tls/keystore/* ${PWD}/organizations/peerOrganizations/seller/peers/peer2.seller/tls/server.key



  mkdir -p ${PWD}/organizations/peerOrganizations/seller/msp/tlscacerts
  cp ${PWD}/organizations/peerOrganizations/seller/peers/peer0.seller/tls/tlscacerts/* ${PWD}/organizations/peerOrganizations/seller/msp/tlscacerts/ca.crt

  mkdir -p ${PWD}/organizations/peerOrganizations/seller/tlsca
  cp ${PWD}/organizations/peerOrganizations/seller/peers/peer0.seller/tls/tlscacerts/* ${PWD}/organizations/peerOrganizations/seller/tlsca/tlsca.seller-cert.pem

  mkdir -p ${PWD}/organizations/peerOrganizations/seller/ca
  cp ${PWD}/organizations/peerOrganizations/seller/peers/peer0.seller/msp/cacerts/* ${PWD}/organizations/peerOrganizations/seller/ca/ca.seller-cert.pem

  infoln "Generating the user msp"

  fabric-ca-client enroll -u https://user1:user1pw@localhost:5500 --caname ca-seller -M ${PWD}/organizations/peerOrganizations/seller/users/User1@seller/msp --tls.certfiles ${PWD}/organizations/fabric-ca/seller/tls-cert.pem


  cp ${PWD}/organizations/peerOrganizations/seller/msp/config.yaml ${PWD}/organizations/peerOrganizations/seller/users/User1@seller/msp/config.yaml

  infoln "Generating the org admin msp"

  fabric-ca-client enroll -u https://selleradmin:selleradminpw@localhost:5500 --caname ca-seller -M ${PWD}/organizations/peerOrganizations/seller/users/Admin@seller/msp --tls.certfiles ${PWD}/organizations/fabric-ca/seller/tls-cert.pem


  cp ${PWD}/organizations/peerOrganizations/seller/msp/config.yaml ${PWD}/organizations/peerOrganizations/seller/users/Admin@seller/msp/config.yaml
}
function createorderer1() {
  infoln "Enrolling the CA admin"
  mkdir -p organizations/ordererOrganizations/orderer1

  export FABRIC_CA_CLIENT_HOME=${PWD}/organizations/ordererOrganizations/orderer1


  fabric-ca-client enroll -u https://admin:adminpw@localhost:2200 --caname ca-orderer1 --tls.certfiles ${PWD}/organizations/fabric-ca/orderer1/tls-cert.pem


  echo 'NodeOUs:
  Enable: true
  ClientOUIdentifier:
    Certificate: cacerts/localhost-2200-ca-orderer1.pem
    OrganizationalUnitIdentifier: client
  PeerOUIdentifier:
    Certificate: cacerts/localhost-2200-ca-orderer1.pem
    OrganizationalUnitIdentifier: peer
  AdminOUIdentifier:
    Certificate: cacerts/localhost-2200-ca-orderer1.pem
    OrganizationalUnitIdentifier: admin
  OrdererOUIdentifier:
    Certificate: cacerts/localhost-2200-ca-orderer1.pem
    OrganizationalUnitIdentifier: orderer' >${PWD}/organizations/ordererOrganizations/orderer1/msp/config.yaml

  infoln "Registering orderer"

  fabric-ca-client register --caname ca-orderer1 --id.name orderer --id.secret ordererpw --id.type orderer --tls.certfiles ${PWD}/organizations/fabric-ca/orderer1/tls-cert.pem


  infoln "Registering the orderer admin"

  fabric-ca-client register --caname ca-orderer1 --id.name ordererAdmin --id.secret ordererAdminpw --id.type admin --tls.certfiles ${PWD}/organizations/fabric-ca/orderer1/tls-cert.pem


  infoln "Generating the orderer msp"

  fabric-ca-client enroll -u https://orderer:ordererpw@localhost:2200 --caname ca-orderer1 -M ${PWD}/organizations/ordererOrganizations/orderer1/config.orderers/msp --csr.hosts orderer1 --csr.hosts localhost --tls.certfiles ${PWD}/organizations/fabric-ca/orderer1/tls-cert.pem


  cp ${PWD}/organizations/ordererOrganizations/orderer1/msp/config.yaml ${PWD}/organizations/ordererOrganizations/orderer1/config.orderers/msp/config.yaml

  infoln "Generating the orderer-tls certificates"

  fabric-ca-client enroll -u https://orderer:ordererpw@localhost:2200 --caname ca-orderer1 -M ${PWD}/organizations/ordererOrganizations/orderer1/config.orderers/tls --enrollment.profile tls --csr.hosts orderer1 --csr.hosts localhost --tls.certfiles ${PWD}/organizations/fabric-ca/orderer1/tls-cert.pem


  cp ${PWD}/organizations/ordererOrganizations/orderer1/config.orderers/tls/tlscacerts/* ${PWD}/organizations/ordererOrganizations/orderer1/config.orderers/tls/ca.crt
  cp ${PWD}/organizations/ordererOrganizations/orderer1/config.orderers/tls/signcerts/* ${PWD}/organizations/ordererOrganizations/orderer1/config.orderers/tls/server.crt
  cp ${PWD}/organizations/ordererOrganizations/orderer1/config.orderers/tls/keystore/* ${PWD}/organizations/ordererOrganizations/orderer1/config.orderers/tls/server.key

  mkdir -p ${PWD}/organizations/ordererOrganizations/orderer1/config.orderers/msp/tlscacerts
  cp ${PWD}/organizations/ordererOrganizations/orderer1/config.orderers/tls/tlscacerts/* ${PWD}/organizations/ordererOrganizations/orderer1/config.orderers/msp/tlscacerts/tlsca-cert.pem

  mkdir -p ${PWD}/organizations/ordererOrganizations/orderer1/msp/tlscacerts
  cp ${PWD}/organizations/ordererOrganizations/orderer1/config.orderers/tls/tlscacerts/* ${PWD}/organizations/ordererOrganizations/orderer1/msp/tlscacerts/tlsca-cert.pem

  infoln "Generating the admin msp"

  fabric-ca-client enroll -u https://ordererAdmin:ordererAdminpw@localhost:2200 --caname ca-orderer1 -M ${PWD}/organizations/ordererOrganizations/orderer1/users/Admin@example.com/msp --tls.certfiles ${PWD}/organizations/fabric-ca/orderer1/tls-cert.pem


  cp ${PWD}/organizations/ordererOrganizations/orderer1/msp/config.yaml ${PWD}/organizations/ordererOrganizations/orderer1/users/Admin@example.com/msp/config.yaml
}
function createorderer2() {
  infoln "Enrolling the CA admin"
  mkdir -p organizations/ordererOrganizations/orderer2

  export FABRIC_CA_CLIENT_HOME=${PWD}/organizations/ordererOrganizations/orderer2


  fabric-ca-client enroll -u https://admin:adminpw@localhost:2201 --caname ca-orderer2 --tls.certfiles ${PWD}/organizations/fabric-ca/orderer2/tls-cert.pem


  echo 'NodeOUs:
  Enable: true
  ClientOUIdentifier:
    Certificate: cacerts/localhost-2201-ca-orderer2.pem
    OrganizationalUnitIdentifier: client
  PeerOUIdentifier:
    Certificate: cacerts/localhost-2201-ca-orderer2.pem
    OrganizationalUnitIdentifier: peer
  AdminOUIdentifier:
    Certificate: cacerts/localhost-2201-ca-orderer2.pem
    OrganizationalUnitIdentifier: admin
  OrdererOUIdentifier:
    Certificate: cacerts/localhost-2201-ca-orderer2.pem
    OrganizationalUnitIdentifier: orderer' >${PWD}/organizations/ordererOrganizations/orderer2/msp/config.yaml

  infoln "Registering orderer"

  fabric-ca-client register --caname ca-orderer2 --id.name orderer --id.secret ordererpw --id.type orderer --tls.certfiles ${PWD}/organizations/fabric-ca/orderer2/tls-cert.pem


  infoln "Registering the orderer admin"

  fabric-ca-client register --caname ca-orderer2 --id.name ordererAdmin --id.secret ordererAdminpw --id.type admin --tls.certfiles ${PWD}/organizations/fabric-ca/orderer2/tls-cert.pem


  infoln "Generating the orderer msp"

  fabric-ca-client enroll -u https://orderer:ordererpw@localhost:2201 --caname ca-orderer2 -M ${PWD}/organizations/ordererOrganizations/orderer2/config.orderers/msp --csr.hosts orderer2 --csr.hosts localhost --tls.certfiles ${PWD}/organizations/fabric-ca/orderer2/tls-cert.pem


  cp ${PWD}/organizations/ordererOrganizations/orderer2/msp/config.yaml ${PWD}/organizations/ordererOrganizations/orderer2/config.orderers/msp/config.yaml

  infoln "Generating the orderer-tls certificates"

  fabric-ca-client enroll -u https://orderer:ordererpw@localhost:2201 --caname ca-orderer2 -M ${PWD}/organizations/ordererOrganizations/orderer2/config.orderers/tls --enrollment.profile tls --csr.hosts orderer2 --csr.hosts localhost --tls.certfiles ${PWD}/organizations/fabric-ca/orderer2/tls-cert.pem


  cp ${PWD}/organizations/ordererOrganizations/orderer2/config.orderers/tls/tlscacerts/* ${PWD}/organizations/ordererOrganizations/orderer2/config.orderers/tls/ca.crt
  cp ${PWD}/organizations/ordererOrganizations/orderer2/config.orderers/tls/signcerts/* ${PWD}/organizations/ordererOrganizations/orderer2/config.orderers/tls/server.crt
  cp ${PWD}/organizations/ordererOrganizations/orderer2/config.orderers/tls/keystore/* ${PWD}/organizations/ordererOrganizations/orderer2/config.orderers/tls/server.key

  mkdir -p ${PWD}/organizations/ordererOrganizations/orderer2/config.orderers/msp/tlscacerts
  cp ${PWD}/organizations/ordererOrganizations/orderer2/config.orderers/tls/tlscacerts/* ${PWD}/organizations/ordererOrganizations/orderer2/config.orderers/msp/tlscacerts/tlsca-cert.pem

  mkdir -p ${PWD}/organizations/ordererOrganizations/orderer2/msp/tlscacerts
  cp ${PWD}/organizations/ordererOrganizations/orderer2/config.orderers/tls/tlscacerts/* ${PWD}/organizations/ordererOrganizations/orderer2/msp/tlscacerts/tlsca-cert.pem

  infoln "Generating the admin msp"

  fabric-ca-client enroll -u https://ordererAdmin:ordererAdminpw@localhost:2201 --caname ca-orderer2 -M ${PWD}/organizations/ordererOrganizations/orderer2/users/Admin@example.com/msp --tls.certfiles ${PWD}/organizations/fabric-ca/orderer2/tls-cert.pem


  cp ${PWD}/organizations/ordererOrganizations/orderer2/msp/config.yaml ${PWD}/organizations/ordererOrganizations/orderer2/users/Admin@example.com/msp/config.yaml
}
function createorderer3() {
  infoln "Enrolling the CA admin"
  mkdir -p organizations/ordererOrganizations/orderer3

  export FABRIC_CA_CLIENT_HOME=${PWD}/organizations/ordererOrganizations/orderer3


  fabric-ca-client enroll -u https://admin:adminpw@localhost:2202 --caname ca-orderer3 --tls.certfiles ${PWD}/organizations/fabric-ca/orderer3/tls-cert.pem


  echo 'NodeOUs:
  Enable: true
  ClientOUIdentifier:
    Certificate: cacerts/localhost-2202-ca-orderer3.pem
    OrganizationalUnitIdentifier: client
  PeerOUIdentifier:
    Certificate: cacerts/localhost-2202-ca-orderer3.pem
    OrganizationalUnitIdentifier: peer
  AdminOUIdentifier:
    Certificate: cacerts/localhost-2202-ca-orderer3.pem
    OrganizationalUnitIdentifier: admin
  OrdererOUIdentifier:
    Certificate: cacerts/localhost-2202-ca-orderer3.pem
    OrganizationalUnitIdentifier: orderer' >${PWD}/organizations/ordererOrganizations/orderer3/msp/config.yaml

  infoln "Registering orderer"

  fabric-ca-client register --caname ca-orderer3 --id.name orderer --id.secret ordererpw --id.type orderer --tls.certfiles ${PWD}/organizations/fabric-ca/orderer3/tls-cert.pem


  infoln "Registering the orderer admin"

  fabric-ca-client register --caname ca-orderer3 --id.name ordererAdmin --id.secret ordererAdminpw --id.type admin --tls.certfiles ${PWD}/organizations/fabric-ca/orderer3/tls-cert.pem


  infoln "Generating the orderer msp"

  fabric-ca-client enroll -u https://orderer:ordererpw@localhost:2202 --caname ca-orderer3 -M ${PWD}/organizations/ordererOrganizations/orderer3/config.orderers/msp --csr.hosts orderer3 --csr.hosts localhost --tls.certfiles ${PWD}/organizations/fabric-ca/orderer3/tls-cert.pem


  cp ${PWD}/organizations/ordererOrganizations/orderer3/msp/config.yaml ${PWD}/organizations/ordererOrganizations/orderer3/config.orderers/msp/config.yaml

  infoln "Generating the orderer-tls certificates"

  fabric-ca-client enroll -u https://orderer:ordererpw@localhost:2202 --caname ca-orderer3 -M ${PWD}/organizations/ordererOrganizations/orderer3/config.orderers/tls --enrollment.profile tls --csr.hosts orderer3 --csr.hosts localhost --tls.certfiles ${PWD}/organizations/fabric-ca/orderer3/tls-cert.pem


  cp ${PWD}/organizations/ordererOrganizations/orderer3/config.orderers/tls/tlscacerts/* ${PWD}/organizations/ordererOrganizations/orderer3/config.orderers/tls/ca.crt
  cp ${PWD}/organizations/ordererOrganizations/orderer3/config.orderers/tls/signcerts/* ${PWD}/organizations/ordererOrganizations/orderer3/config.orderers/tls/server.crt
  cp ${PWD}/organizations/ordererOrganizations/orderer3/config.orderers/tls/keystore/* ${PWD}/organizations/ordererOrganizations/orderer3/config.orderers/tls/server.key

  mkdir -p ${PWD}/organizations/ordererOrganizations/orderer3/config.orderers/msp/tlscacerts
  cp ${PWD}/organizations/ordererOrganizations/orderer3/config.orderers/tls/tlscacerts/* ${PWD}/organizations/ordererOrganizations/orderer3/config.orderers/msp/tlscacerts/tlsca-cert.pem

  mkdir -p ${PWD}/organizations/ordererOrganizations/orderer3/msp/tlscacerts
  cp ${PWD}/organizations/ordererOrganizations/orderer3/config.orderers/tls/tlscacerts/* ${PWD}/organizations/ordererOrganizations/orderer3/msp/tlscacerts/tlsca-cert.pem

  infoln "Generating the admin msp"

  fabric-ca-client enroll -u https://ordererAdmin:ordererAdminpw@localhost:2202 --caname ca-orderer3 -M ${PWD}/organizations/ordererOrganizations/orderer3/users/Admin@example.com/msp --tls.certfiles ${PWD}/organizations/fabric-ca/orderer3/tls-cert.pem


  cp ${PWD}/organizations/ordererOrganizations/orderer3/msp/config.yaml ${PWD}/organizations/ordererOrganizations/orderer3/users/Admin@example.com/msp/config.yaml
}



