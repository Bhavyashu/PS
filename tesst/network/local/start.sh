# grant access to the network file
#cd ..
#chmod -R +x ./local
#cd ./local

# bring down the current network
./network.sh down

# Pull the images
./bootstrap.sh 2.2.3 1.5.1

# bring up the network
./network.sh up -ca -s couchdb

# create the assemble
./network.sh createChannel -c assemble -p DefaultChannel

# package and install 'assemble' chaincode on all org nodes
./network.sh deployCC -ccn bandsql -ccp ../../chaincode -ccl go -ccsd true

# deploy chaincode on assemble
# ./network.sh deployCC -c defaultchannel -ccn bandsql -ccp ../../chaincode -ccl go -cci Init -ccsp true
./network.sh deployCC -c assemble -ccn bandsql -ccp ../../chaincode -ccl go -ccsp true


