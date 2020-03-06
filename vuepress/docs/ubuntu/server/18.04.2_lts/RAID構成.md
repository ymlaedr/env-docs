# RAID構成

## サーバー機のスペック
- CPU: Intel® Core™ i7-4765T CPU @ 2.00GHz × 8 
- メモリ: 23.4GiB
- HDD1〜4: 1.8TiB
- インストールディスク: [ubuntu-18.04.2-server-amd64.iso](http://cdimage.ubuntu.com/releases/18.04.2/release/ubuntu-18.04.2-server-amd64.iso)




## パーティションの切り方
- [参考サイト](https://www.linuxmania.jp/raid_md_grub.html#boot)
- [HDD分割の計算用 - ysv-main](https://docs.google.com/spreadsheets/d/1n862Q1giBNudgCFslIFI_Qc0ZNSvpNBraK8Y5_nIHoM/edit#gid=1278515555)

|        使途        |   値 | 単位 | 開始セクタ | 終了セクタ | セクタ数（512Bytes） | フラグ |
| :----------------: | ---: | :--: | ---------: | ---------: | -------------------: | :----: |
|      空き領域      |    1 | MiB  |            |       2047 |                 2048 |        |
| EFI boot partition |  120 | MiB  |       2048 |     247807 |               245760 |   B    |
|  raid1 for /boot   | 1024 | MiB  |     247808 |    2344959 |              2097152 |        |
|    raid5 for /     | 1845 | GiB  |    2344960 | 3871590399 |           3869245440 |        |
|     linux swap     |   16 | GiB  | 3871590400 | 3905144831 |             33554432 |        |
|      後ろ残り      |  100 | MiB  | 3905144832 | 3905349631 |               204800 |        |



## インストール時の各種情報

#### `cat /proc/mdstat`
```
```

#### `mdadm --detail /dev/md0`
```
```

#### `mdadm --detail /dev/md1`
```
```



## HDDが死んだ場合の復旧手順
参考: [ubuntu 14.04でのraid1作成、復旧手順（その2）](https://qiita.com/miyumiyu/items/cab3c09084c00a308669)

#### 障害が発生しているか確認
```sh
cat /proc/mdstat
```

#### 障害の発生したHDDをRAIDから削除
例えば、`/dev/sdd`で障害が起こった場合
```sh
mdadm /dev/md0 --fail /dev/sdd2
mdadm /dev/md0 --remove /dev/sdd2
mdadm /dev/md1 --fail /dev/sdd3
mdadm /dev/md1 --remove /dev/sdd3
```

#### 新しくHDDを追加、パーティションの作成
パーティションの切り方を参考に行う

#### RAIDアレイへHDDを追加
```sh
mdadm /dev/md0 --add /dev/sdd2
mdadm /dev/md1 --add /dev/sdd3
```