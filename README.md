_This project has been created as part of the 42 curriculum by ktomita._

# Born2beroot

## Description

このプロジェクトでは、仮想環境上にLinuxを指定されたパーティション構成でインストールした後、

- SSHサーバーの構築
- ファイアウォールの設定
- ホスト名の設定
- ユーザーやグループの管理
- パスワードやパスワードポリシーの設定
- `sudo`コマンドのインストールと構成
- システムの各種コマンドを使用して定期的にブロードキャストするためのシェルスクリプトを作成する
- wallコマンドを利用したブロードキャスト

などを実装する。

これによって、システム管理者としての基本的なスキルを身につけることができる。

---

## Instructions

レビューシートに書かれているだろう具体的な指示に従い検証を行った後に、実際に仮想マシンを起動してそれぞれの機能が正しく動作するかを確認する。

このプロジェクトは校舎PCの、Ubuntu 22.04 LTS上のVirtualBoxで実行することを想定している。

---

## Resources

`man` コマンドについては、インストールした`Debian GNU/Linux 13.6 (trixie)`に内蔵されていたmanページを参照した。

なお、明示的に書かれていない場合でも、それぞれのコマンドの理解のために、`man` コマンドや、`--help` `-h` のようなオプションなどを利用している場合がある。

参考にしたWebサイトや、具体的にどこで何を参照したかについては、課題の制約下の中で可読性を少しでも上げるために各セクション内にリンクを貼る形で記載したため、ここでは省略する。

### AI Usage

- 検索の補助
- GitHub Copilotのコード補完機能による、装飾記号を中心としたMarkdown執筆の補助
- 誤字や脱字の有無の確認

のみに利用した。

---

## Project Description

以降では、課題の指示に求められた要件についてまとめている。

### システムの違いについて

このセクションでは、"required additions"として課題で求められている「違い」を説明するべき項目について解説をする。

#### a. Debian vs Rocky Linux

どちらも、Windows 11やMac OS 26、iOS 26、Android 17、Ubuntuのような、OSの一種である。

Linuxには、ディストリビューションという異なる種類の違うものがある。

Debianは、Debian Projectによって開発されているフリーなOSである。UbuntuやRaspberry Pi OSなどの多くのソフトウェアの派生元となるOSとなっている。校舎のPCにインストールされているUbuntu 22.04 LTSも、Debianをベースにして開発されたOSである。安定性がある一方でリリースが遅く、新機能などを利用することができないというデメリットがある。

一方で、Rocky LinuxはRed Hat Enterprise Linuxから直接派生したOSで、CentOSの正式な後継である。Red Hat Enterprise Linuxのソースコードを利用して開発されている

> Rocky Linux is a community-driven Enterprise Linux distribution— stable enough for the largest enterprise to rely on it, and community-driven to ensure it stays accessible to all.

とある通り、コミュニティによるエンタープライズレベルのLinuxディストリビューションであると述べられている。一方で、その派生元などの性質上サーバー向けの用途が強いため、デスクトップOSとしての用途はあまり向いていないというデメリットがある。

どちらを選択するかという点については、個人の好みや今までの経験、利用するソフトウェアなどによると私は考えている。今回、私はRaspberry PiでのRaspberry Pi OSの利用や、Minecraftサーバーの構築にUbuntuを利用したことが多くあることから、Debianを選択した。もし私がCentOSやRed Hat Enterprise Linuxを利用したことが多くある場合は、サーバー向きOSとしてはRocky Linuxを選択していたかもしれない。

[Debian -- Reasons to use Debian](https://www.debian.org/intro/why_debian)

[第1章 定義と概要](https://www.debian.org/doc/manuals/debian-faq/basic-defs.ja.html)

[Rocky Linux](https://rockylinux.org/)

[About - Rocky Linux](https://rockylinux.org/about)

[What are the disadvantages of using debian ? : r/linuxquestions](https://www.reddit.com/r/linuxquestions/comments/ttaohv/what_are_the_disadvantages_of_using_debian/)

[What's the appeal of Rocky Linux? : r/RockyLinux](https://www.reddit.com/r/RockyLinux/comments/vzng0q/whats_the_appeal_of_rocky_linux/)

---

#### b. AppArmor vs SELinux

AppArmorとは、ユーザーやグループによる権限管理だけではなく、実行ファイルごとに権限を分けることによってセキュリティの向上を図るものである。これは、`Application-Centric` と公式サイトに説明されている通りである。

一方で、SELinuxは、より広範な設定を可能にするものである。例えば、アプリケーションやプロセス、ファイルなどに対するアクセス制限が可能である。

どちらも、UNIXのシステムではDAC (任意アクセス制御)が採用されている中で、MAC(強制アクセス制御)を可能にするものである。つまり、sudoなどの権限を通して強制的に実行することができなくなるようにするもので、root以外権限設定を変更することができなくなるようにするものである。

[AppArmor #Security - Qiita](https://qiita.com/propella/items/a6b646916b48029c369e)

[SELinux とは？をわかりやすく解説](https://www.redhat.com/ja/topics/linux/what-is-selinux)

- [AppArmor Documentation - AppArmor](https://www.apparmor.net/)
- [AppArmor vs SELinux - AppArmor](https://www.apparmor.net/about/apparmor_vs_selinux/)

[DAC(任意アクセス制御)とMAC(強制アクセス制御)、RBAC(ロールベースアクセス制御)の違い #初心者 - Qiita](https://qiita.com/miyuki_samitani/items/acde77784237e482aef8)

---

#### c. UFW vs firewalld

Uncomplicated Firewall、通称UFWはnetfilter firewallを制御するものである。

firewalldもおおよそ同様なものであり、システムの制御をするためのものである。

どちらも、Linuxのシステム上で動作する、ファイアーウォールというネットワークにおいて外部からのアクセスなどを制限する仕組みである。

[ufw in Launchpad](https://launchpad.net/ufw)

[Home | firewalld](https://firewalld.org/)

[ファイアウォールとは? そのしくみと機能、役割について解説 - Microsoft for business](https://www.microsoft.com/ja-jp/area/biz/smb/column-firewall)

---

#### d. VirtualBox vs UTM

どちらもハイパーバイザー、ホストのリソースとゲストのリソースをつなぐソフトウェアである。

Virtual Boxは、Oracle社によって開発されている仮想化ソフト。物理的なコアやメモリを割り当てた上で、ゲストOSをホストのCPU上で直接実行することができる。(これをVirtualizationという)

UTMはQEMUという仮想化技術をベースにした仮想化ソフト。Virtualizationだけではなく、Emulationによって、異なるアーキテクチャのOSを動かしたりすることができる。

違いは

- 開発元が違う
- 対応する仮想化の方法が異なる

[わかりやすくQEMUを説明してみる（第1回）：QEMUの利用シーン | PDT(プロファウンド・デザイン・テクノロジー）](https://www.profound-dt.co.jp/qemu/qemu_chap1/)

[About QEMU — QEMU documentation](https://www.qemu.org/docs/master/about/)

[サーバー仮想化とは？3つの方式とメリット・デメリットを解説](https://crexgroup.com/ja/development/development/what-is-server-virtualization/)

[Oracle VirtualBox](https://www.virtualbox.org/)

[Home | UTM Documentation](https://docs.getutm.app/)

##### 仮想化とは

仮想化とは、1つのPCの構成を仮想的に作成した上で。主に別のPCそれを動かす仕組みのことである。

###### メリット

- ホストの端末のOSやハードウェアに関わらず、動作する可能性が高い
- 複製や配布などが比較的容易
- 複数のハードウェアを用いなくとも複数のマシンを仮想的に利用することができ、リソースの最適化をすることができる

###### デメリット

- ホストのOSを起動させた上でゲストのOSも動かさなければならず、また様々な要因によってオーバーヘッドが生じる
- 仮想化をするソフトウェアに依存する

---

#### e. Advanced Package Manager (APT) vs `apt` vs `aptitude`

この3つは、少し複雑な関係となっている。

`apt` も `aptitude` も1つのコマンドであり、どちらもAdvanced Package Manager (APT) をベースにして作られている。

`apt` はDebianにプリインストールされているもので、必要である基本的な機能を兼ね備えている。事実、私は初回提出までこれを利用することはなかった。

一方で、`aptitude`は、Debianにプリインストールされていないもので、独自のターミナル上でのUIを持っているほか、対話型での操作が可能である、自動で解決できなかった複雑な依存関係の解決も可能である。

[apt、apt-get、aptitude](https://zenn.dev/ryo18/articles/aca1c5823a9aaa)

[【Linux】Debianのapt、apt-get、aptitudeの違い | アカスブログ](https://ac-as.net/apt-apt-get-aptitude-difference/)

[aptitude - Wikipedia](https://ja.wikipedia.org/wiki/Aptitude)

---

### Details

このセクションでは、自分が行ったデザインや、実装した機能について説明する。

#### a. Installation

##### インストールメディアの入手

公式の方法に従って、インストールメディアを入手しインストールした。その上で、VMware上で起動ディスクとしてISOファイルを指定して起動した。

[2.4. Installation Media](https://www.debian.org/releases/trixie/amd64/ch02s04.en.html)

##### VMwareの設定

- 仮想ディスク: 48GiB (ホストOS上の実際のディスクの使用量は使用した分だけであるので、これより少ないことが多い)
- メモリ: 4~8GBを想定
- コア数: 2コア以上を想定

パーティションについては以降のセクションで追記。

##### 適用した処理

1. Virtual Boxから新規仮想マシンを作成、メモリやCPUコア数の割当をし、インストールメディアを初期状態としてインストールする。
2. 起動し、Debianのセットアップユーティリティに従ってセットアップを進める。その際に、ユーザーの作成やホスト名の設定、ディスクのパーティション分割、セットアップ時にインストールするソフトウェアの指定、アップデート先の設定などを行った。
3. セットアップが終了して起動し、以降のターミナル上でのセットアップを進める。

---

#### b. パーティション分割

48GiBのディスクを想定して今回はパーティションの分割を行った。

##### Debianのインストール中にやったもの

1. `/boot` を先にパーティションとして確保する
2. 残りを利用して暗号化されたボリュームのグループを作成する
3. それぞれのボリュームを作成する

##### それぞれの領域

###### 1. `/boot`

- 2GiBを割当
  - Ubuntuでは実際に1.8GBほど専有された例がある
  - ファームウェアの更新をする可能性があるため、ゆとりを持つように

[Installing ubuntu do I really need a boot partition? - Super User](https://superuser.com/questions/66015/installing-ubuntu-do-i-really-need-a-boot-partition)

[linux - Why create many partitions? - Super User](https://superuser.com/questions/30216/why-create-many-partitions)

[What is the recommended size for a Linux /boot partition? - Server Fault](https://serverfault.com/questions/334663/what-is-the-recommended-size-for-a-linux-boot-partition/1029458#1029458)

###### 2. `/`

- 残りすべて
- 他の項目を考えた場合の適当なサイズ
- 最後に設定する、自分の工夫として主張

###### 3. `[SWAP]`

[9.15.5. Recommended Partitioning Scheme | Installation Guide | Red Hat Enterprise Linux | 6 | Red Hat Documentation](https://docs.redhat.com/en/documentation/red_hat_enterprise_linux/6/html/installation_guide/s2-diskpartrecommend-x86)

- 4GiB
- ディスクの容量が不足したときに使用する領域

**理由**

- 2-8GBの物理メモリに適するものとして、2GBを選択
- hibernationは使用しないため
- もともと2GBを想定していたが、サーバーというクラッシュが致命的になりやすい環境ではゆとりを持つことがベータだと感じたから

###### 4. `/home`

ホームディレクトリ。ユーザーの個人データを保存する場所。10GiBに設定。

###### 5. `/var`

実行中に変更されるデータについてまとめたもの。4GiBに設定。

###### 6. `/srv`

コンテンツの配信などに利用されるディレクトリ。4GiBに設定。

[fhs - What's the most appropriate directory where to place files shared between users? - Unix & Linux Stack Exchange](https://unix.stackexchange.com/questions/70700/whats-the-most-appropriate-directory-where-to-place-files-shared-between-users)

###### 7. `/tmp`

OSなどによって生成される仮のファイル。4GiBに設定。

[Logical Volume Manager (LVM) versus standard partitioning in Linux](https://www.redhat.com/en/blog/lvm-vs-partitioning)

###### 8. `/var/log`

ログが保存されるディレクトリ。2GiBに設定。

ログファイルによっては、ログの内容が膨大になりシステムの領域を逼迫する場合があるため、ログの保存先を別のパーティションにすることでサービスが停止することを防ぐことができる。

- `/var/log/journal` ファイルにOS起動の際のログが残されている
- `journalctl` コマンドでログを取得可能
  - 中には8MBものファイルがある
  - バイナリファイル? 文字化けしている

**`/var/log/README`**

> You are looking for the traditional text log files in /var/log, and they are gone?
>
> Here's an explanation on what's going on:
>
> You are running a systemd-based OS where traditional syslog has been replaced with the Journal. The journal stores the same (and more) information as classic syslog. To make use of the journal and access the collected log data simply invoke "journalctl", which will output the logs in the identical text-based format the syslog files in /var/log used to be. For further details, please refer to journalctl(1).
>
> Alternatively, consider installing one of the traditional syslog implementations available for your distribution, which will generate the classic log files for you. Syslog implementations such as syslog-ng or rsyslog may be installed side-by-side with the journal and will continue to function
> the way they always did.
>
> Thank you!

つまり、ログの記録の方法が変わったらしい。`journalctl > a.txt` などで取得はであった。(一部内容についてはrootでないと取得できなかった。)

##### 目的

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

##### 比較

###### LVM vs Partition

Partitionは、従来のようにディスクを分割する。このメリットについては別に説明。

一方で、LVMとは、複数の物理ディスク(PV)やパーティションなどをまとめてVolume Groupとし、その中に論理ボリューム(Logical Volume)を作成することができる仕組みである。従来のパーティションの場合、パーティション分割後のサイズの変更などが困難な場合があるが、LVMではディスクのサイズを柔軟に変更をすることができる。

LVM:
[Logical Volume Manager (LVM) versus standard partitioning in Linux](https://www.redhat.com/en/blog/lvm-vs-partitioning)

###### MBR vs GPT

|                      | MBR         | GPT        |
| -------------------- | ----------- | ---------- |
| システム             | BIOSベース  | UEFI       |
| ディスクのサイズ     | 最大2TBまで | ほぼ無制限 |
| パーティションの個数 | 4個まで     | 128個まで  |

[BIOSとUEFIってなんだ？〜PCの起動を支える2つのファームウェアを完全理解〜 #UEFI - Qiita](https://qiita.com/GeneLab_999/items/c9aa79a988d9c67b00e6)

[Chapter 5. Secure Installation | Security Guide | Red Hat Enterprise Linux | 6 | Red Hat Documentation](https://docs.redhat.com/en/documentation/red_hat_enterprise_linux/6/html/security_guide/chap-security_guide-secure_installation)

##### その他参考

[C.3. Recommended Partitioning Scheme](https://www.debian.org/releases/bookworm/amd64/apcs03.en.html)

[lsblk Command in Linux with Examples - GeeksforGeeks](https://www.geeksforgeeks.org/linux-unix/lsblk-command-in-linux-with-examples/)

---

#### c. sudo

##### インストール

Rootで以下のコマンドを実行

```
apt install sudo
```

##### 使用方法

[【Linux入門】sudoを完全に理解する。仕組み・使い方。そして3つの責任 #Linux - Qiita](https://qiita.com/Shiro_Shihi/items/f34c1aa7bb1cb5118c70)

1. インストール
2. デフォルトの設定で `sudo` グループに属する人が利用可能になっているのでグループを追加

##### 設定方法

```
# @Born2beroot

## sudoコマンドで呼び出しできるパスを宣言
Defaults        secure_path="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"

## パスワード試行回数
Defaults        passwd_tries=3

## ログ
Defaults        log_input, log_output
Defaults        logfile=/var/log/sudo/sudo.log

## パスワードミス時のメッセージ変更
Defaults        badpass_message="Calm down, ensure that the command you are trying to execute is correct and please try again. :<"

# This fixes CVE-2005-4890 and possibly breaks some versions of kdesu
# (#1011624, https://bugs.kde.org/show_bug.cgi?id=452532)
# ptyからのsudoを禁ずる (=tty modeのみ)
Defaults        use_pty
```

[【備忘録】linuxでsudoを安全に使うための設定](https://zenn.dev/taisei1/articles/962a84e1dbe3a2)

[How can I change the number of password entry attempts allowed by sudo? - Ask Ubuntu](https://askubuntu.com/questions/534868/how-can-i-change-the-number-of-password-entry-attempts-allowed-by-sudo)

[bash - sudo change default error message - Stack Overflow](https://stackoverflow.com/questions/41058328/sudo-change-default-error-message)

[Ubuntu Manpage: 名前](https://manpages.ubuntu.com/manpages/trusty/ja/man5/sudoers.5.html)

```sh
man sudoers
```

##### 詳細

###### pty vs tty

> A pseudoterminal (sometimes abbreviated "pty") is a pair of virtual character devices that provide a bidirectional communication channel. One end of the channel is called the master; the other end is called the slave.

[擬似コード - Wikipedia](https://ja.wikipedia.org/wiki/%E6%93%AC%E4%BC%BC%E3%82%B3%E3%83%BC%E3%83%89)

疑似ターミナル

- 1段階ある、

ttyは、「テレタイプ」が語源である。しかしながら、当時のこの技術がプロトコルとして使われている。UNIX環境においては、何かしらの形でユーザーの手によって、入出力ができるターミナルが割り当てられていることであると認識している。

例えば、

```sh
ssh [接続先] sudo apt update
```

は`sudo: sorry, you must have a tty to run sudo` と表示されてできない。

この有無は `tty` コマンドを利用することによって確認できる。ただし、パイプを通して利用された場合には利用できる場合がある。

[What is Pseudo TTY-Allocation? (SSH and Github) - Stack Overflow](https://stackoverflow.com/questions/17900760/what-is-pseudo-tty-allocation-ssh-and-github)

[テレタイプ端末 - Wikipedia](https://ja.wikipedia.org/wiki/%E3%83%86%E3%83%AC%E3%82%BF%E3%82%A4%E3%83%97%E7%AB%AF%E6%9C%AB)

[sshを使ってリモートマシンでコマンドを叩く際の注意点 - 覚書](https://satoru-takeuchi.hatenablog.com/entry/2017/04/11/223932)

データを1文字ずつ入力すると、物理的に1文字ずつそれが反映されるする時代があった

この通信方式をそのまま利用している

---

#### d. hostname

こちらはセットアップ時に済ませてしまったが、`hostnamectl set-hostname [ホスト名]` で設定することができる。

---

#### e. SSH

リモートでターミナルにアクセスするためのプロトコルである。SSHサーバーのプログラムを接続先の端末で実行した状態で、接続したい端末から `ssh` コマンドを利用することで、リモートでターミナルにアクセスすることができる。

セットアップ時にインストールは済ませてしまった。

##### 設定ファイル

`/etc/ssh/sshd_config` を編集する。

##### 変更箇所

```
Port 4242

...

PermitRootLogin no
```

公開鍵認証などを設定するための要素はなかったので、このままにする。

---

#### f. UFW

UFWがインストールされていなかった場合には、`sudo apt install ufw` でインストールする。

その後、

```
sudo ufw allow 4242
sudo ufw allow 80
sudo ufw status
```

を実行することで、SSHのポート4242と、lighttpdのポート80を許可する。その後、

```
sudo ufw enable
```

を実行することで、UFWを有効化する。

---

#### g. Groups

##### 方法

前提: `/etc/group` を変更しても結果的に同じことができるが、コマンド経由でやることを推奨

`gpasswd` コマンドなど、方法も色々ある

##### 確認

`groups` コマンドで現在ユーザーが所属するグループを確認

##### グループの...

###### 追加

`groupadd user42` のようにしてグループを追加

###### 削除

`groupdel groupname`

##### ユーザーの...

###### 追加

`usermod -aG groupname username`
`usermod -a -G groupname username`

- `-a`: Appendする
- `-G groupname` groupnameを追加する

[Groups Command in Linux - GeeksforGeeks](https://www.geeksforgeeks.org/linux-unix/groups-command-in-linux-with-examples/)

###### 削除

`deluser username groupname`

---

#### h. Passwords

##### パスワードの設定について

###### `pam-pwquality`

libpwqualityがまだインストールされていない場合、インストールする。

```sh
sudo apt install libpwquality
```

以下の2ファイルを編集する

**`/etc/pam.d/common-password`**

```
password    requisite               pam_pwquality.so retry=3 minlen=10 ucredit=-1 ...
```

**`/etc/security/pwquality.conf/`**

```
difok = 7
```

[pwquality.conf(5) - Linux man page](https://linux.die.net/man/5/pwquality.conf)
[libpwquality/libpwquality: Password quality checking library](https://github.com/libpwquality/libpwquality)

```sh
man 5 pwquality.conf
man 8 pam_pwquality
```

###### `/etc/login.defs`

以下のように編集をする。

```txt
PASS_MAX_DAYS   30
PASS_WARN_DAYS  7
PASS_MIN        2
```

こうすることで、30日後にパスワードを変更させられるようになる。

ただし、これは新規ユーザーにしか適用されないので、既存のユーザーに適用させるには

```sh
sudo chage -m 2 -M 30 -W 7 [user]
```

をする必要がある。

参考:

```sh
man 5 login.defs
man 1 chage
```

---

#### i. monitoring.sh

ここでは、シェルスクリプトを作成する。なお、このファイルの権限は全員が読み取り可能で、rootのみが書き込み可能にする。

##### カーネルのバージョン

```sh
uname --all
```

[Linuxカーネルのバージョン #コマンド - Qiita](https://qiita.com/baba0512/items/2bb89be58c534d7faf35)

##### CPU / vCPU

`/proc/cpuinfo` の `physical id` の数のうち、重複するものを削除してwcコマンドを利用することで、異なるphysical idの数を元に異なる物理CPUの数を数えることができる。

vCPUの数は、nprcコマンドの結果をそのまま採用した。

[[memo] Linux で CPU の数を調べる #Bash - Qiita](https://qiita.com/yoshi389111/items/a9026769a6c6a8786c90)

[LinuxでCPUのコア数を確認する方法｜物理コア・スレッド数を簡単チェック！ | ちょげぶろぐ](https://www.choge-blog.com/programming/linux-cpu-numberofcore/#toc7)

##### メモリ使用率

メモリの使用率については、`free`コマンドの出力結果を`grep`等で加工して出力した。またBashの算術展開を利用して、計算を行った。

[Linuxのメモリ使用率を確認する方法は？【top/free/psコマンドの使い方解説】 - インフラ学習サイト「InfraAcademy」](https://engineer-ninaritai.com/linux-memory-usage/)

[Bashで文字列を切り出す方法｜部分文字列・末尾取得・cutとの使い分けを解説 - Bash道](https://bashdo.com/post/bash%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%97%E3%83%88%E5%88%9D%E5%BF%83%E8%80%85%E5%BF%85%E8%A6%8B%EF%BC%81%E6%96%87%E5%AD%97%E5%88%97%E3%81%AE%E5%88%87%E3%82%8A%E5%87%BA%E3%81%97%E6%96%B9%E6%B3%95/#toc8)

[正規表現\_よく使う正規表現30選 #正規表現 - Qiita](https://qiita.com/mitsuha_003/items/15c0b2ce00ed8f1b57ae)

[【bashシェル】コマンドの実行結果を変数に格納する | 秋拓技術学院](https://syutaku.blog/bash-cmd-get-execution-result/)

[メモリ不足でサーバーが遅い？｜freeコマンドでリソース状況を即チェック - Bash道](https://bashdo.com/post/%e3%83%a1%e3%83%a2%e3%83%aa%e4%b8%8d%e8%b6%b3%e3%81%a7%e3%82%b5%e3%83%bc%e3%83%90%e3%83%bc%e3%81%8c%e9%81%85%e3%81%84%ef%bc%9f%ef%bd%9cfree%e3%82%b3%e3%83%9e%e3%83%b3%e3%83%89%e3%81%a7%e3%83%aa/)

[cut コマンドで連続した空白による区切りを処理したい #Linux - Qiita](https://qiita.com/kkdd/items/c29dba9f077a7dd19fe5)

[Bash $((算術式)) のすべて - A 基本編 #ShellScript - Qiita](https://qiita.com/akinomyoga/items/9761031c551d43307374)

[Bashの算術展開（Arithmetic Expansion）を使いこなそう | エンジニア術](https://engineerjutsu.com/bash-arithmetic-expansion/#li_yong_ke_nengna_yan_suan_zito_ji_shu)

##### ディスク使用率

こちらについては、`df`コマンドの出力結果を予め定義した配列 `mnts` を利用してfor文によって、それぞれ`grep`等で加工して出力したものを、Bashの算術展開を利用して足し合わせた。

[【Linux】 ディスク使用量の表示（df / du / ncdu） | hirota.noの技術ブログ〜 It's all over the network.](https://hirotanoblog.com/linux-disk-usage/12766/)

[awk 基礎 #Linux - Qiita](https://qiita.com/yabeenico/items/a9a70c9d911a11f17899#%E4%BB%A3%E5%85%A5%E6%BC%94%E7%AE%97%E5%AD%90--%E3%82%92%E6%B4%BB%E7%94%A8)

[Bashのfor文は3種類｜最適な書き方と安全テンプレ14選 - Bash道](https://bashdo.com/post/bash-for/#toc9)

[sed で n行目以降だけ表示 - Shell | nju33](https://nju33.com/notes/shell/articles/sed%20%E3%81%A7%20n%E8%A1%8C%E7%9B%AE%E4%BB%A5%E9%99%8D%E3%81%A0%E3%81%91%E8%A1%A8%E7%A4%BA#sed_%E3%81%A7_n%E8%A1%8C%E7%9B%AE%E4%BB%A5%E9%99%8D%E3%81%A0%E3%81%91%E8%A1%A8%E7%A4%BA)

[sed コマンド｜テキスト置換・削除・抽出の基本から実務パターンまで - Bash道](https://bashdo.com/post/sed/)

[Bashシェルスクリプトで数値配列の合計値を算出する | ゲンゾウ用ポストイット](https://genzouw.com/entry/2020/05/07/102250/1991/)

##### Network

IPアドレスについては、1つでないといけない指定はなかったので、`hostname` コマンドで取得したIPアドレスを利用して、ループバックアドレスを除くすべてのIPアドレスを表示することにした。

enpのような接頭群がある。これは、PCIe接続のものに対して適用されるもので、MACアドレスに関してはこちらのデバイスのみを表示させるようにした。

[Networkデバイスの名前慣習メモ #Network - Qiita](https://qiita.com/tetz-akaneya/items/a7a75b2026dd3b25bb4a)

[第11章 ネットワークデバイス命名における一貫性 | ネットワークガイド | Red Hat Enterprise Linux | 7 | Red Hat Documentation](https://docs.redhat.com/ja/documentation/red_hat_enterprise_linux/7/html/networking_guide/ch-consistent_network_device_naming)

[[Linux]grepコマンドと正規表現 #Linux - Qiita](https://qiita.com/tochisuke221/items/e95216cd8b2ccbf1a5ca)

[[Linux]grepコマンドと正規表現 #Linux - Qiita](https://qiita.com/tochisuke221/items/e95216cd8b2ccbf1a5ca#%E3%81%A7%E4%BD%8D%E7%BD%AE%E3%82%92%E7%A4%BA%E3%81%99)

##### LVM

`lvs`コマンドを利用して、LVMボリュームを利用しているか取得した。なお、こちらのコマンドには管理者権限が必要である。

##### TCP Conntections

`ss --tcp` コマンドを利用した。こちらのコマンドは、ソケットの調査をするためのツールである。

##### ログイン数

`w` コマンドを利用した。こちらは、ユーザーのログイン状況を1列につき1ユーザーの情報を表示するコマンドなので、`-h` オプションを利用してヘッダーを非表示にした上で、`wc -l` コマンドで行数を数えることで、ログインしているユーザーの数を取得することができる。

##### sudoコマンド

こちらは、ファイルを手動で作成するようにしたので、そのファイルの長さを2で割ることで、sudoコマンドの実行回数を取得することができる、とした。なお、失敗したsudoコマンドの実行回数もカウントされる。

##### crontab

Linuxにおいて、定期的な処理を実行するための仕組みとして、cronというものがある。`crontab -e` コマンドを利用することで、比較的かんたんに定期的な処理を実行することができる。その構文は、わかりやすくコマンド実行時に編集するファイルに掲載されていることが多い。

##### Wall

メッセージをブロードキャストするためのコマンドである。`wall` コマンドを利用することで、ログインしているユーザーに対してメッセージを送信することができる。デフォルトで、引数、ファイル名、あるいは標準入力からの入力を受け付けることができる。

---

#### j. MariaDBについて

##### インストール

公式サイトより、aptリポジトリを取得してMariaDBをインストールする。

直接 `sudo apt install mariadb-server` でインストールすることも可能だが、公式の手段に従うことでより確実に最新バージョンのものを利用することができる。

[Download MariaDB Server - MariaDB.org](https://mariadb.org/download/?t=mariadb&p=mariadb&r=12.3.2)

データベース設定は公式の手段に従って実施。当然、現時点ではローカルからしか接続をしないDBのポート開放などはしないように設定。

また、WordPressのインストール時に、MariaDBのユーザーを作成し権限を付与する必要がある。

---

#### k. lighttpdについて

##### インストール方法

###### lighttpd

```sh
sudo apt update
sudo apt install lighttpd lighttpd-doc
```

[WikiStart - Lighttpd - lighty labs](https://redmine.lighttpd.net/projects/lighttpd/wiki#Get-Lighttpd)

[Home - lighty news](https://www.lighttpd.net/)

###### PHPのサポート用のパッケージ

また、PHPを利用するためには、外部のパッケージをインストールする必要がある。

その際に利用されるのがCGIという仕組みであり、これを利用することで別のパッケージを利用してPHPコードを実行し、その結果をlighttpdを通してユーザーに返すことができる。

[CGIってなんじゃ #Web - Qiita](https://qiita.com/_lvyuu/items/a90652cad440fdee21e8)

```sh
sudo apt update
sudo apt install php-fpm
```

##### 構成

###### サーブするディレクトリ

今回は、`/srv/`ディレクトリを利用するこの構成を活用しつつ、互換性を保つために、`/var/www`を`/srv/www`にシンボリックリンクをした。

```sh
sudo ln -s /src/www /var/www # 元 -> 先
```

実際のHTMLファイルは、`/srv/www/html` に配置されていて、現在はWordPressのPHPファイルなどが配置されている。

[Linux入門：シンボリックリンクの基本と活用術をわかりやすく解説してみた #Linuxコマンド - Qiita](https://qiita.com/free-honda/items/9ca5e6f2e6079b653277)

[php - What is /var/www/html? - Stack Overflow](https://stackoverflow.com/questions/16197663/what-is-var-www-html)

[Linux FHS: /srv vs /var ... where do I put stuff? - Server Fault](https://serverfault.com/questions/124127/linux-fhs-srv-vs-var-where-do-i-put-stuff)

###### 設定ファイル

`/etc/lighttpd/lighttpd.conf` を編集する。

ここで、サーバーのディレクトリの指定やPHPの設定などを行う。

[debian - Lighttpd static file server 403 forbidden error - Server Fault](https://serverfault.com/questions/692490/lighttpd-static-file-server-403-forbidden-error)

[WikiStart - Lighttpd - lighty labs](https://redmine.lighttpd.net/projects/lighttpd/wiki#Get-Lighttpd)

##### トラブルシューティング

上記の設定をしても、接続がうまくいかない場合には、以下の点を確認する。

###### ファイルの権限

ファイルの権限が適切に設定されていない場合、lighttpdがファイルを読み込むことができず、403エラーなどが発生する場合がある。

###### ファイアーウォールの設定

```sh
sudo ufw allow 80
```

###### VirtualBoxのPort Forwardingの設定

Virtual MachineのNetwork設定から、ポートフォワーディングが適切に設定されているか確認する。

###### ホストOS上での紐付けのポートを8080にする

以上の設定を行っても、私の環境では正常にWordPressのインストールページにアクセスすることができなかった。

問題の検討をしたところ、デフォルトのHTTPのポート80がすでに利用されているなどの理由で、仮想マシンとのPort Forwardingがうまく行かない場合があるということに気づいた。この場合、ポートを `ゲスト 80:8080 ホスト` のように紐付けをするとうまく行く場合がある。

---

#### i. WordPress

##### インストール

公式サイトを参考に、ファイルをダウンロードした。

その際に、lighttpdとMariaDBの設定を行った上でWordPressのインストールを行う。https通信への対応は、証明書の取得などをする必要があるため、今回は省略した。

なお、具体的なディレクトリやデータベースの設定についてはそれぞれのセクションで説明されている。

##### セットアップ

1. PHPが利用可能なWebサーバーを用意する。
1. サーブされるディレクトリにWordPressのサイトからファイルをダウンロードする。
1. ブラウザからWordPressのインストールページにアクセスし、データベースの設定やユーザーの作成などを行う。

[How to install WordPress – Advanced Administration Handbook | Developer.WordPress.org](https://developer.wordpress.org/advanced-administration/before-install/howto-install/)

---

#### j. Docker

Dockerとは、コンテナ仮想化のソフトの1つである。

##### ハイパーバイザとの違い

Dockerは、VirtualBoxのようなハイパーバイザとは違い、カーネルなどをホストOSと共有し、1つのプロセスとしてコンテナと呼ばれる単位で実行される。一方で、ハイパーバイザーは、当然親のOSに関わらず、仮想マシン上に独立したカーネルを持つ。このほかにもレイヤーという概念や、カーネルの機能を活用することで仮想マシンに比べてDockerは軽量で高速に動作することができる。詳細についてはInceptionの課題でやることであるため、ここでは省略する。

[Dockerはなぜ速い？軽量仮想化の秘密「カーネル共有とレイヤー構造」を徹底深掘り](https://zenn.dev/hokahiro/articles/docker-question)

##### インストール方法

ドキュメントをコピー&ペーストして実行した。具体的には、公式のaptリポジトリの取得のためのキーを取得してから、`systemctl`コマンドを利用してOSの起動と同時にDockerのデーモンも起動するようにしてインストールするという作業をしている。その際に、リポジトリを取得せずに`apt`コマンドでインストールするなど、他の方法でインストールされた可能性のあるものを削除する作業も行う。

インストールが完了したら、`sudo docker run hello-world`を利用することで実際にテスト用のコンテナを動作させることができる。

[Install Docker Engine on Debian | Docker Docs](https://docs.docker.com/engine/install/debian/)

##### なぜインストールしたのか

- DockerにはDaemonが必要で、そのデーモンは`a service`の要件を満たせるから
- サービスのデプロイや、ソフトウェア開発のツールとして広く使用されているから

---

#### k. Ports

- `:68` `:546` デフォルトのDHCPクライアントのポート
- `:80` lighttpd / WordPressのポート
- `:3306` MariaDBのポート
- `:4242` SSHのポート

これらのうち、ufwで許可したのは当然、SSHのポートとlighttpdのポートのみである。

このため、課題のPDFと `ss` コマンドの出力が違うが、問題ない。

#### l. チェックサム

この課題では提出の際にチェックサムを計算して提出する必要がある。これを利用することで、同一ファイルから得られる一意の文字列を照合し、ファイルの整合性を確認することができる。

また当然、GitリポジトリにVMのイメージを直接pushすることは、Git LFSなどの仕組みを利用しない限りはできないこともこの提出方法を採用した理由であると考えられる。

その歳、`sha1sum` コマンドを利用したが、その出力は

```
[チェックサム]  [ファイル名]
```

のような形式だったため、課題の指示を考慮した上でチェックサム部分のみを抽出して、`signature.txt` に書き込むようにした。
