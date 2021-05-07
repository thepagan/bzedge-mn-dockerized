<img height="204" src="https://github.com/thepagan/bzedge/raw/bzedge/doc/imgs/bzedge-logo.png">

### Checkout latest full releases here: https://github.com/bze-alphateam/bzedge/releases


# BZEdge
 - **Keep your wallet running to strengthen the BZEdge network.**
 - **Backup your wallet in many locations & keep your coins wallet offline.**

# BZedge Masternode Docker Container

### Ports:
- RPC port: 1980
- P2P port: 1990

## Masternode Docker Container
### Masternode Requirements
1. A VPS (Datacentres have redundancies in the event of problems)
   1. [Vultr](https://www.vultr.com/?ref=8843254)
   2. [DigitalOcean](https://m.do.co/c/5ae4210dcad1)
   3. [Hostinger](https://www.hostinger.com/vps-hosting)
3. A control wallet ([TENTWallet](https://tent.app/wallet) or [bzedged/bzedge-cli](https://github.com/bze-alphateam/bzedge/releases) used to hold your MN collateral\
**YOUR FUNDS ARE ALWAYS KEPT IN YOUR CONTROL WALLET ON YOUR PC**\
**You should NEVER keep your funds on the VPS**

### VPS System Requirements
MN Collateral: 250,000 BZE\
Min. System Req.: 1 CPU / 1 GB RAM / 2GB Swap / 20 GB HDD\
Rec. System Req.:2 CPU / 1 GB RAM / 2GB Swap / 20 GB HDD\
OS: Ubuntu 16/18 or Debian

Install
-----------------

## Docker

Container is available on DockerHub

```
docker pull thepagan/bzedge-mn:latest
```
