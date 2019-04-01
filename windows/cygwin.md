# [Cygwin Terminal](https://cygwin.com/install.html)

## インストール
1. [公式サイト](https://cygwin.com/install.html)からインストーラを引っ張ってくるか、scoopからインストールする。  
2. インストーラー(setup.exe)を実行。デフォルトのインストール先を選択し、wgetのみあらかじめインストールしておく。
3. Cygwin起動。
4. 下記を実行し、apt-cygをインストールする。
    ```sh
    # apt-cygのインストール。ubuntuでいうところのapt-getのようなことができる
    # wget -O apt-cyg https://raw.githubusercontent.com/transcode-open/apt-cyg/master/apt-cyg
    wget -O apt-cyg https://raw.githubusercontent.com/kou1okada/apt-cyg/master/apt-cyg
    mv apt-cyg /usr/local/bin 
    chmod +x /usr/local/bin/apt-cyg
    echo '
    # ----<apt-cyg>----
    alias apt-cyg="apt-cyg -X"' \
      >> ~/.bashrc
    source ~/.bashrc
    ```
5. 下記を実行し、各種ツールをインストールする。
    ```sh
    # アップデートと各種パッケージインストール
    apt-cyg update
    apt-cyg install \
      git \
      ncurses \
      procps \
      screen \
      shutdown \
      vim
    ```
6. 下記を実行し、cocotをインストールする。
    ```sh
    # cocotのインストール。Cygwin上でWindowsアプリケーションを実行した際の文字化けを解消する
    apt-cyg update
    apt-cyg install \
      automake \
      gcc-core \
      gcc-g++ \
      inetutils \
      libiconv \
      libiconv-devel \
      make
    git clone http://github.com/vmi/cocot
    cd cocot/
    find . -type f | xargs sed -i -e 's/\r//g'
    ./configure --prefix=/usr/local/bin && make && make install
    chmod +x /usr/local/bin/cocot
    cd ../ && rm -rf cocot
    echo '
    # ----<cocot>----
    alias arp="cocot arp"
    alias cmd="cocot cmd"
    alias java="cocot java"
    alias ifconfig="cocot ipconfig"
    alias netstat="cocot netstat"
    alias nslookup="cocot nslookup"
    alias ping="cocot ping"
    alias powershell="cocot powershell"
    alias route="cocot route"
    alias traceroute="cocot tracert"' \
      >> ~/.bashrc 
    ```
7. 下記を実行し、winptyをインストールする。
    ```sh
    apt-cyg install \
      gcc-g++ \
      mingw64-x86_64-gcc-g++
    git clone https://github.com/rprichard/winpty.git
    cd ./winpty
    ./configure && make && make install 
    cd ../ && rm -rf ./winpty
    ```

