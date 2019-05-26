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
COMPOSE_VERSION=1.24.0

git clone git@github.com:docker/compose.git \
 && cd compose && git checkout refs/tags/${COMPOSE_VERSION} \
 && docker build -t docker-compose:armhf -f Dockerfile.armhf . \
 && docker run --rm --entrypoint="script/build/linux-entrypoint" -v $(pwd)/dist:/code/dist -v $(pwd)/.git:/code/.git "docker-compose:armhf" \
 && docker rmi "docker-compose:armhf" \
 && sudo cp dist/docker-compose-Linux-armv7l /usr/local/bin/docker-compose \
 && sudo chown root:root /usr/local/bin/docker-compose \
 && sudo chmod 0755 /usr/local/bin/docker-compose
```

1. [公式のリポジトリ](https://github.com/docker/compose/)から好きなバージョンを探す
2. クローン先へ移動、対象のバージョンtagへcheckout
3. armhf用のDockerfileからバイナリのビルド用イメージをビルド
4. ビルド用イメージをrun
5. 完了後にビルド用イメージを削除
6. 生成されたdocker-composeの実行用バイナリをパスの通った場所へ移動
7. 実行権限の付与