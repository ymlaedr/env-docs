# RaspbianへDocker&docker-composeのインストール

## Docker

### スクリプト
```sh
curl -sSL https://get.docker.com/ | sh
```
公式が用意してくれた、環境に合わせて自動的にインストールしてくれる代物。



## docker-compose

### スクリプトとその流れ
```sh
COMPOSE_VERSION=1.23.2

apt update \
 && apt upgrade -y \
 && apt install -y python3 python3-pip

sudo pip3 install docker-compose==${COMPOSE_VERSION}
```