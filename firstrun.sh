#!/bin/bash
sudo touch /etc/systemd/system/bzedged.service
sudo chown bzedge:bzedge /etc/systemd/system/bzedged.service
ls -al /etc/systemd/system
sudo cat << EOF > /etc/systemd/system/bzedged.service
[Unit]
Description=BZEdged service
After=network.target
[Service]
Type=forking
User=bzedge
Group=bzedge
WorkingDirectory=/home/bzedge/.bzedge
ExecStart=/home/bzedge/bzedge/src/bzedged -datadir=/home/bzedge/.bzedge/ -conf=/home/bzedge/.bzedge/bzedge.conf -daemon
ExecStop=/home/bzedge/bzedge/src/bzedge-cli stop
Restart=always
RestartSec=3
PrivateTmp=true
TimeoutStopSec=60s
TimeoutStartSec=10s
StartLimitInterval=120s
StartLimitBurst=5
[Install]
WantedBy=multi-user.target
EOF
sudo chown root:root /etc/systemd/system/bzedged.service
sudo systemctl daemon-reload
sudo systemctl enable bzedged.service > /dev/null 2>&1
sleep 4
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
echo "rpcuser="$(pwgen -n 8 1) >> ~/.bzedge/bzedge.conf
echo "rpcpassword="$(pwgen -n 20 1) >> ~/.bzedge/bzedge.conf
sudo systemctl start bzedged.service
echo "Starting the BZEdge daemon for the first time..."
sleep 5
MNKEY=$(~/bzedge/src/bzedge-cli masternode genkey)
echo "masternodeprivkey=$MNKEY" >> ~/.bzedge/bzedge.conf
echo "masternode=1" >> ~/.bzedge/bzedge.conf
echo "Enter Transaction ID:"
read TXID
echo "Enter Output Index:"
read OIND
echo "mn01 $IP:1990 $MNKEY $TXID $OIND" >> ~/.bzedge/masternode.conf
echo "This is your private key:"
echo $MNKEY
bzedge-cli stop
sleep 4
sudo systemctl start bzedged
echo "Starting the BZEdge daemon with the new configuration...."
sleep 4
