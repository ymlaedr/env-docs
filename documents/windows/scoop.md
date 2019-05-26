# [scoop]()

## インストール

1. PowerShell起動。下記を実行する
```ps1
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force
iex (New-Object net.webclient).downloadstring('https://get.scoop.sh')
```

## `extra bucket`の追加
```ps1
scoop bucket add extras
```

## scoop自体のアップデート
```ps1
scoop update
```

## すべてのアプリのアップデート
```ps1
scoop update *
```