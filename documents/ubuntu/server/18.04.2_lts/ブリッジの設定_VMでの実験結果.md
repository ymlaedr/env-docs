# ブリッジの設定_VMでの実験結果

## IPアドレスの確認
```sh
ip a
```

## ゲートウェイの確認
```sh
ip route show
```

## DNSサーバーのアドレス確認
```sh
cat /etc/resolv.conf
```

## 設定ファイルの設置
```sh
NETWORK_DEVICE_NAME=ens3
V4_IP_ADDRESS_WITH_SUBNET_MASK=192.168.122.142/24
V4_GATEWAY_ADDRESS=192.168.122.1
V4_DNS_SERVER_ADDRESS=8.8.8.8

for NETPLAN in `ls /etc/netplan/*`; do
    mv $NETPLAN ${NETPLAN}.old
done
echo \
"network:
  ethernets:
    ${NETWORK_DEVICE_NAME}:
      dhcp4: false
      dhcp6: false
  bridges:
    br0:
      interfaces:
        - ${NETWORK_DEVICE_NAME}
      dhcp4: false
      dhcp6: false
      addresses:
        - ${V4_IP_ADDRESS_WITH_SUBNET_MASK}
      gateway4: ${V4_GATEWAY_ADDRESS}
      nameservers:
        addresses:
          - ${V4_DNS_SERVER_ADDRESS}
      parameters:
        forward-delay: 0
        stp: false
      optional: true
  version: 2" \
> /etc/netplan/50-cloud-init.yaml
```

## 適用
```sh
ip addr flush dev
netplan apply
```