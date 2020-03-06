# RAID構成_VMでの実験結果



## VMのスペック
VirtManagerを使用
- CPU(2コア設定): Haswell-noTSX-IBRS
- メモリ: 4096MB
- HDD1〜4: 20.00GiB
- インストールディスク: [ubuntu-18.04.2-server-amd64.iso](http://cdimage.ubuntu.com/releases/18.04.2/release/ubuntu-18.04.2-server-amd64.iso)



## パーティションの切り方
- [HDD分割の計算用 - ysv-main](https://docs.google.com/spreadsheets/d/1n862Q1giBNudgCFslIFI_Qc0ZNSvpNBraK8Y5_nIHoM/edit#gid=1278515555)

|        使途        |    値 | 単位 | 開始セクタ | 終了セクタ | セクタ数（512Bytes） | フラグ |
| :----------------: | ----: | :--: | ---------: | ---------: | -------------------: | :----: |
|      空き領域      |     1 | MiB  |            |       2047 |                 2048 |        |
| EFI boot partition |   120 | MiB  |       2048 |     247807 |               245760 |   B    |
|  raid1 for /boot   |  1024 | MiB  |     247808 |    2344959 |              2097152 |        |
|    raid5 for /     | 17.75 | GiB  |    2344960 |   39569407 |             37224448 |        |
|     linux swap     |     1 | GiB  |   39569408 |   41666559 |              2097152 |        |
|      後ろ残り      |   100 | MiB  |   41666560 |   41871359 |               204800 |        |



## インストール時のパーティション設定のスクリーンショット

#### HDD4枚のパーティション設定
![Screenshot_ubuntu18.04_2019-07-29_00:47:39.png](screen_shots/Screenshot_ubuntu18.04_2019-07-29_00:47:39.png)

#### `/boot`用のRAID1設定
![Screenshot_ubuntu18.04_2019-07-29_00:43:48.png](screen_shots/Screenshot_ubuntu18.04_2019-07-29_00:43:48.png)

#### `/`用のRAID5設定
![Screenshot_ubuntu18.04_2019-07-29_00:45:00.png](screen_shots/Screenshot_ubuntu18.04_2019-07-29_00:45:00.png)

#### RAID1,RAID5へのマウントポイント設定
![Screenshot_ubuntu18.04_2019-07-29_00:49:04.png](screen_shots/Screenshot_ubuntu18.04_2019-07-29_00:49:04.png)



## インストール完了後の各種情報

#### `cat /proc/mdstat`
```
Personalities : [raid1] [raid6] [raid5] [raid4] [linear] [multipath] [raid0] [raid10] 
md1 : active raid5 vdc3[2] vdd3[3] vdb3[1] vda3[0]
      51950592 blocks super 1.2 level 5, 512k chunk, algorithm 2 [4/4] [UUUU]
      
md0 : active raid1 vdb2[1] vdd2[3] vdc2[2] vda2[0]
      999424 blocks super 1.2 [4/4] [UUUU]
      
unused devices: <none>
```

#### `mdadm --detail /dev/md0`
```
/dev/md0:
           Version : 1.2
     Creation Time : Mon Jul 29 00:44:31 2019
        Raid Level : raid1
        Array Size : 999424 (976.00 MiB 1023.41 MB)
     Used Dev Size : 999424 (976.00 MiB 1023.41 MB)
      Raid Devices : 4
     Total Devices : 4
       Persistence : Superblock is persistent

       Update Time : Mon Jul 29 10:45:13 2019
             State : clean 
    Active Devices : 4
   Working Devices : 4
    Failed Devices : 0
     Spare Devices : 0

Consistency Policy : resync

              Name : ubuntu:0  (local to host ubuntu)
              UUID : b7ec5eac:5d32e7f6:e4c663dd:0b965a7d
            Events : 17

    Number   Major   Minor   RaidDevice State
       0     252        2        0      active sync   /dev/vda2
       1     252       18        1      active sync   /dev/vdb2
       2     252       34        2      active sync   /dev/vdc2
       3     252       50        3      active sync   /dev/vdd2
```

#### `mdadm --detail /dev/md1`
```
/dev/md1:
           Version : 1.2
     Creation Time : Mon Jul 29 00:45:06 2019
        Raid Level : raid5
        Array Size : 51950592 (49.54 GiB 53.20 GB)
     Used Dev Size : 17316864 (16.51 GiB 17.73 GB)
      Raid Devices : 4
     Total Devices : 4
       Persistence : Superblock is persistent

       Update Time : Mon Jul 29 16:09:38 2019
             State : clean 
    Active Devices : 4
   Working Devices : 4
    Failed Devices : 0
     Spare Devices : 0

            Layout : left-symmetric
        Chunk Size : 512K

Consistency Policy : resync

              Name : ubuntu:1  (local to host ubuntu)
              UUID : 18be09b2:d66a52e9:b0ca3c17:874b6618
            Events : 17

    Number   Major   Minor   RaidDevice State
       0     252        3        0      active sync   /dev/vda3
       1     252       19        1      active sync   /dev/vdb3
       2     252       35        2      active sync   /dev/vdc3
       3     252       51        3      active sync   /dev/vdd3
```



## HDDが一つ死んだ場合に復旧が効くか
効く。(はず)
今回のやり方だと、ブートローダがすべてのHDDにインストールされたようだ。
