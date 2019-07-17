# Xming

## インストール
方法は２つ。
1. 公式から落とす
2. scoopを使ってインストール
    ```sh
    scoop install xming
    ```

## 初期化
1. 下記を実行してホームディレクトリへ設定ファイルを設置
    ```sh
    echo "<XLaunch xmlns=\"http://www.straightrunning.com/XmingNotes\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xsi:schemaLocation=\"http://www.straightrunning.com/XmingNotes XLaunch.xsd\" WindowMode=\"MultiWindow\" ClientMode=\"NoClient\" Display=\"0\" Clipboard=\"true\"/>" \
    >> ~/config.xlaunch
    ```

2. 下記を実行して.bashrcへ設定書き込み
    ```sh
    echo "
    ## ----<xming settings>----
    export DISPLAY=localhost:0.0
    function runx() {
        if [ $(tasklist.exe | grep xlaunch | grep -v grep | wc -l) -ge 1 ]; then
            echo \"xlaunch.exe is already started.\"
        else
            echo \"Starting xlaunch.exe\"
            xlaunch.exe -run ~/config.xlaunch &
        fi
    }
    " >> ~/.bashrc
    ```

## 実行
```sh
runx
```