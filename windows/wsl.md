# WSL(Windows Subsystem for Linux)

# インストール
1. 取得
Windows StoreにてUbuntuを検索すると同名のアプリがある。  
これをインストールする。  

2. 初期化
初回起動時、Initializeが走る。  
user,passwordの入力を求められるので、Windowsと同じアカウント名・パスワードを設定しておく。  

3. aptのミラーリポジトリ設定
下記を実行する
```sh
sudo su
sed \
  -i.bak \
  -e "s%# deb-src http://security.ubuntu.com/ubuntu/%deb-src http://security.ubuntu.com/ubuntu/%g" \
    /etc/apt/sources.list
sed \
  -i.bak \
  -e "s%http://security.ubuntu.com/ubuntu/%http://ftp.jaist.ac.jp/pub/Linux/ubuntu/%g" \
    /etc/apt/sources.list

apt update
```

