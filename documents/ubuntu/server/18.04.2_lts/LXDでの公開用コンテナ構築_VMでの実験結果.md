# LXDでの公開用コンテナ構築_VMでの実験結果



## 初期化
```
$ sudo lxd init
Would you like to use LXD clustering? (yes/no) [default=no]:                                                            
Do you want to configure a new storage pool? (yes/no) [default=yes]:                                                    
Name of the new storage pool [default=default]:             
Name of the storage backend to use (btrfs, dir, lvm) [default=btrfs]: dir                                               
Would you like to connect to a MAAS server? (yes/no) [default=no]:                                                      
Would you like to create a new local network bridge? (yes/no) [default=yes]: no                                         
Would you like to configure LXD to use an existing bridge or host interface? (yes/no) [default=no]: yes                 
Name of the existing bridge or host interface: br0          
Would you like LXD to be available over the network? (yes/no) [default=no]: yes                                         
Address to bind LXD to (not including port) [default=all]:  
Port to bind LXD to [default=8443]:                         
Trust password for new clients:                             
Again:                                                      
No password set, client certificates will have to be manually trusted.Would you like stale cached images to be updated automatically? (yes/no) [default=yes]
Would you like a YAML "lxd init" preseed to be printed? (yes/no) [default=no]:
```



## Docker用LXDコンテナ作成
```sh
sudo lxc launch \
  ubuntu:18.04 bionic-docker \
  -c security.nesting=true \
  -c security.privileged=true
```



## コンテナへアクセス
```sh
LXD_CONTAINER_NAME='bionic-docker'
lxc exec ${LXD_CONTAINER_NAME} -- bash
```



## Docker・docker-composeのインストール
```sh
apt install -y \
  apt-transport-https \
  ca-certificates \
  curl \
  software-properties-common \
 && curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - \
 && add-apt-repository \
  "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) \
  stable" \
 && apt update && apt install -y docker-ce \
 && curl \
  -fsSL \
    https://github.com/docker/compose/releases/download/1.18.0/docker-compose-`uname -s`-`uname -m` \
  -o \
    /usr/local/bin/docker-compose
 && chmod +x /usr/local/bin/docker-compose
```