_This project has been created as part of the 42 curriculum by ktomita._

# Born2beroot

## Description

このプロジェクトでは、

## Project Description

Summary: このセクションでは、"required additions"として課題で求められている「違い」を説明するべき項目について解説をする。

### システムの違いについて

#### Debian vs Rocky Linux

どちらも、Windows 11やMac OS 26、iOS 26、Android 17、Ubuntuのような、OSの一種である。

Linuxには、ディストリビューションという異なる種類の違うものがある。

Debianは、Debian Projectによって開発されているフリーなOSである。UbuntuやRaspberry Pi OSなどの多くのソフトウェアの派生元となるOSとなっている。

一方で、Rocky LinuxはRed Hat Enterprise Linuxから直接派生したOSで、CentOSの正式な後継である。

> Rocky Linux is a community-driven Enterprise Linux distribution— stable enough for the largest enterprise to rely on it, and community-driven to ensure it stays accessible to all.

とある通り、コミュニティによるエンタープライズレベルのLinuxディストリビューションであると述べられている。

- [Debian -- Reasons to use Debian](https://www.debian.org/intro/why_debian)
- [第1章 定義と概要](https://www.debian.org/doc/manuals/debian-faq/basic-defs.ja.html)
- [Rocky Linux](https://rockylinux.org/)

[About - Rocky Linux](https://rockylinux.org/about)

### AppArmor vs SELinux

AppArmorとは、ユーザーやグループによる権限管理だけではなく、実行ファイルごとに権限を分けることによってセキュリティの向上を図るものである。これは、`Application-Centric` と公式サイトに説明されている通りである。

一方で、SELinuxは、より広範な設定を可能にするものである。例えば、アプリケーションやプロセス、ファイルなどに対するアクセス制限が可能である。

どちらも、UNIXのシステムではDAC (任意アクセス制御)が採用されている中で、MAC(強制アクセス制御)を可能にするものである。つまり、sudoなどの権限を通して強制的に実行することができなくなるようにするもので、root以外権限設定を変更することができなくなるようにするものである。

[AppArmor #Security - Qiita](https://qiita.com/propella/items/a6b646916b48029c369e)

[SELinux とは？をわかりやすく解説](https://www.redhat.com/ja/topics/linux/what-is-selinux)

- [AppArmor Documentation - AppArmor](https://www.apparmor.net/)
- [AppArmor vs SELinux - AppArmor](https://www.apparmor.net/about/apparmor_vs_selinux/)

[DAC(任意アクセス制御)とMAC(強制アクセス制御)、RBAC(ロールベースアクセス制御)の違い #初心者 - Qiita](https://qiita.com/miyuki_samitani/items/acde77784237e482aef8)



### UFW vs firewalld

Uncomplicated Firewall、通称UFWはnetfilter firewallを制御するものである。(TODO: Fix)

 [ufw in Launchpad](https://launchpad.net/ufw)

### VirtualBox vs UTM

どちらもハイパーバイザー、ホストのリソースとゲストのリソースをつなぐソフトウェアである。

Virtual Boxは、Oracle社によって開発されている仮想化ソフト。物理的なコアやメモリを割り当てた上で実行する、ハードウェアによる仮想化 (TODO: もっとちゃんと調べる)

UTMはQEMUという仮想化技術をベースにした仮想化ソフト。エミュレータによって、異なるアーキテクチャのOSを動かしたりすることができる。

違いは
- 開発元が違う
- 仮想化の方法が若干違う
- 

[わかりやすくQEMUを説明してみる（第1回）：QEMUの利用シーン | PDT(プロファウンド・デザイン・テクノロジー）](https://www.profound-dt.co.jp/qemu/qemu_chap1/)

[サーバー仮想化とは？3つの方式とメリット・デメリットを解説](https://crexgroup.com/ja/development/development/what-is-server-virtualization/)

エミュレータ・シミュレータ (TODO: もっとちゃんと調べる)

[Oracle VirtualBox](https://www.virtualbox.org/)
[Home | UTM Documentation](https://docs.getutm.app/)

## 適用した処理

1. Virtual Boxから新規仮想マシンを作成、メモリやCPUコア数の割当をし、インストールメディアを初期状態としてインストールする。
2. 起動し、Debianのセットアップユーティリティに従ってセットアップを進める。その際に、ユーザーの作成やホスト名の設定、ディスクのパーティション分割、セットアップ時にインストールするソフトウェアの指定、アップデート先の設定などを行った。
3. セットアップが終了して起動し、パッケージのインストールを開始した。
