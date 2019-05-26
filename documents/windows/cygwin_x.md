# Cygwin_X
[参考サイト](https://qiita.com/mansonsp/items/1c52668b2f46002a754c)

## インストール
```sh
apt-cyg update
apt-cyg install \
  xorg-server \
  xinit \
  openssh

echo '
# ----<x11>----
if [ -n "{$DISPLAY}" ]; then
    export DISPLAY="localhost:0.0"
fi
PID_XWIN=`ps -e | grep "xwin" | awk "{print $1}"`
if [ ${#PID_XWIN} -eq 0 ]; then
    startxwin -- -listen tcp > /dev/null 2>&1 &
    clear
fi' \
  >> ~/.bashrc 
```
