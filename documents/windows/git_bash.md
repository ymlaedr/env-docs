# [Git Bash]()

## インストール
方法は２つ。
1. 公式から落とす
2. scoopを使ってインストール
    ```sh
    scoop install git
    ```

## 環境整備
以下の問題に対応するため、下記を実行する
1. windowsのコマンドをたたくと、文字化けを起こす

    ```sh
    touch ~/.bash_profile
    touch ~/.bashrc
    echo "
    ## GitBash上で利用したいwindowsコマンドを指定
    WIN_CMDS=(
        \"ping\"
        \"ipconfig\"
        \"netstat\"
        \"tracert\"
    )
    ## 文字化け対応用処理(https://shellscript.sunone.me/array.html)
    function wincmd() {
        CMD=\$1
        shift
        \$CMD \$* 2>&1 | iconv -f cp932 -t utf-8
    }
    for CMD in  \"\${WIN_CMDS[@]}\";
    do
        alias \${CMD}='wincmd \${CMD}'
    done


    " >> ~/.bashrc
    ```