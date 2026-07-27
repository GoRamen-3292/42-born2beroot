# パーティション分割について

## 概要

- 48GiBのディスクを想定

## Debianのインストール中にやったもの

1. `/boot` を先にパーティションとして確保する
2. 残りを利用して暗号化されたボリュームのグループを作成する
3. それぞれのボリュームを生成する

## それぞれの領域

### 1. `/boot`

- 2GiBを割当
  - Ubuntuでは実際に1.8GBほど専有された例がある
  - ファームウェアの更新をする可能性があるため、ゆとりを持つように

[Installing ubuntu do I really need a boot partition? - Super User](https://superuser.com/questions/66015/installing-ubuntu-do-i-really-need-a-boot-partition)

[linux - Why create many partitions? - Super User](https://superuser.com/questions/30216/why-create-many-partitions)

[What is the recommended size for a Linux /boot partition? - Server Fault](https://serverfault.com/questions/334663/what-is-the-recommended-size-for-a-linux-boot-partition/1029458#1029458)

### 2. `/`

- 残りすべて
- 他の項目を考えた場合の適当なサイズ
- 最後に設定する、自分の工夫として主張

### 3. `[SWAP]`

[9.15.5. Recommended Partitioning Scheme | Installation Guide | Red Hat Enterprise Linux | 6 | Red Hat Documentation](https://docs.redhat.com/en/documentation/red_hat_enterprise_linux/6/html/installation_guide/s2-diskpartrecommend-x86)

- 4GiB
- ディスクの容量が不足したときに使用する領域

#### 理由

- 2-8GBの物理メモリに適するものとして、2GBを選択
- hibernationは使用しないため
- もともと2GBを想定していたが、サーバーというクラッシュが致命的になりやすい環境ではゆとりを持つことがベータだと感じたから

### 4. `/home`

10GiB

### 5. `/var`

4GiB

TODO: 調べる

### 6. `/srv`

4GiB

TODO: 調べる

[fhs - What's the most appropriate directory where to place files shared between users? - Unix & Linux Stack Exchange](https://unix.stackexchange.com/questions/70700/whats-the-most-appropriate-directory-where-to-place-files-shared-between-users)

### 7. `/tmp`

4GiB

TODO: 調べる

[10.04 - How large should I make root, [Logical Volume Manager (LVM) versus standard partitioning in Linux](https://www.redhat.com/en/blog/lvm-vs-partitioning)me-usr-var-and-tmp-partitions)

### 8. `/var/log`

2GiB

TODO: 調べる

ログファイル

- `/var/log/journal` ファイルにOS起動の際のログが残されている
- `journalctl` コマンドでログを取得可能
  - 中には8MBものファイルがある
  - バイナリファイル? 文字化けしている

#### `/var/log/README`

> You are looking for the traditional text log files in /var/log, and they are gone?
> 
> Here's an explanation on what's going on:
> 
> You are running a systemd-based OS where traditional syslog has been replaced with the Journal. The journal stores the same (and more) information as classic syslog. To make use of the journal and access the collected log data simply invoke "journalctl", which will output the logs in the identical text-based format the syslog files in /var/log used to be. For further details, please refer to journalctl(1).
> 
> Alternatively, consider installing one of the traditional syslog implementations available for your distribution, which will generate the classic log files for you. Syslog implementations such as syslog-ng or rsyslog may be installed side-by-side with the journal and will continue to function
the way they always did.
> 
> Thank you!

つまり、ログの記録の方法が変わったらしい。`journalctl > a.txt` などは引き続き可能であった。(一部内容についてはrootでないと取得できなかった。)

## 違い

### LVM vs Partition

TODO: 調べる

Partitionは、従来のようにディスクを分割する。このメリットについては別に説明。

一方で、LVMとは、複数の物理ディスク / ボリュームをまとめてVolume Groupとし、その中で... TODO: 続きを書く

LVM: 
[Logical Volume Manager (LVM) versus standard partitioning in Linux](https://www.redhat.com/en/blog/lvm-vs-partitioning)

## 参考

[C.3. Recommended Partitioning Scheme](https://www.debian.org/releases/bookworm/amd64/apcs03.en.html)

[lsblk Command in Linux with Examples - GeeksforGeeks](https://www.geeksforgeeks.org/linux-unix/lsblk-command-in-linux-with-examples/)

## 目的

以下のような形にする

`lsblk` コマンドを使用すると

- sda1: `type=part` `/boot`
- sda5: `type=part`
  - sda5_crypt: `type=crypt`
    - LVMGroup-root:

> パーティションを分けたときのメリットは主に下の3点です。
>
> - 障害発生時、被害を１つのパーティション内に限定することができる
> - システムに合わせた柔軟な利用が可能となる
> - 容量圧迫による他パーティション内のファイルへの影響を避けられる
>
> [パーティションとは何か \#Linux - Qiita](https://qiita.com/m0chim0chi/items/265b28d61f6e6eeea54d)

## 比較

### MBR vs GPT

|                      | MBR         | GPT       |
| -------------------- | ----------- | --------- |
| システム             | BIOSベース  | UEFI      |
| ディスクのサイズ     | 最大2TBまで | 無制限    |
| パーティションの個数 | 4個まで     | 128個まで |
