#!/bin/bash
echo "rpcport=1980" >> ~/.bzedge/bzedge.conf 
echo "daemon=1" >> ~/.bzedge/bzedge.conf 
echo "txindex=1" >> ~/.bzedge/bzedge.conf 
echo "maxconnections=256" >> ~/.bzedge/bzedge.conf 
echo "server=1" >> ~/.bzedge/bzedge.conf 
echo "listen=1" >> ~/.bzedge/bzedge.conf
IP=$(dig +short myip.opendns.com @resolver1.opendns.com)
echo "externalip=[$IP]:1990" >> ~/.bzedge/bzedge.conf
echo "masternodeaddr=[$IP]:1990" >> ~/.bzedge/bzedge.conf 
echo "rpcbind=[$IP]:1980" >> ~/.bzedge/bzedge.conf
echo "bind=[$IP]:1990" >> ~/.bzedge/bzedge.conf
echo "masternode=1" >> ~/.bzedge/bzedge.conf
MNKEY=$(~/bzedge/src/bzedge-cli masternode genkey)
echo "masternodeprivkey=$MNKEY" >> ~/.bzedge/bzedge.conf
echo "Transaction ID:"
read TXID
echo "Output Index:"
read OIND
echo "mn01 $IP:1990 $MNKEY $TXID $OIND" >> ~/.bzedge/masternode.conf
