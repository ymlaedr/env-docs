# Xming

## インストール
方法は２つ。
1. 公式から落とす
2. scoopを使ってインストール
    ```sh
    scoop install xming
    ```
3. 下記実行でホームディレクトリへ設定ファイルを設置
    ```sh
    echo "<XLaunch xmlns=\"http://www.straightrunning.com/XmingNotes\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xsi:schemaLocation=\"http://www.straightrunning.com/XmingNotes XLaunch.xsd\" WindowMode=\"MultiWindow\" ClientMode=\"NoClient\" Display=\"0\" Clipboard=\"true\"/>" \
    >> ~/config.xlaunch
    ```

4. 下記実行で.bashrcへ設定書き込み
    ```sh
    echo "
    ## ----<xming settings>----
    export DISPLAY=localhost:0.0
    function runx() {
        xlaunch.exe -run ~/config.xlaunch &
    }" \
    >> ~/.bashrc
    ```

## 実行
```sh
runx
```