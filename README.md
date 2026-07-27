_This project has been created as part of the 42 curriculum by ktomita._

# Born2beroot

## Description

このプロジェクトでは、

## Project Description

Summary: このセクションでは、"required additions"として課題で求められている「違い」を説明するべき項目について解説をする。

### システムの違いについて

#### Debian vs Rocky Linux

Debianは、Debian Projectによって開発されているフリーなOSである。Ubuntuなどの多くのソフトウェアのベースとなるOSとなっていて、

- [Debian -- Reasons to use Debian](https://www.debian.org/intro/why_debian)
- [第1章 定義と概要](https://www.debian.org/doc/manuals/debian-faq/basic-defs.ja.html)

### AppArmor vs SELinux

TODO: 記述する

- [AppArmor Documentation - AppArmor](https://www.apparmor.net/)
- [AppArmor vs SELinux - AppArmor](https://www.apparmor.net/about/apparmor_vs_selinux/)

### UFW vs firewalld

Uncomplicated Firewall、通称UFWはnetfilter firewallを制御するものである。(TODO: Fix)

 [ufw in Launchpad](https://launchpad.net/ufw)

### VirtualBox vs UTM

Virtual Boxは、Oracle社によって開発されている仮想化ソフトで、

ハードウェアによる仮想化 (TODO: もっとちゃんと調べる)

UTMはQEMUという仮想化技術をベースにした仮想

エミュレータ・シミュレータ (TODO: もっとちゃんと調べる)

[Oracle VirtualBox](https://www.virtualbox.org/)
[Home | UTM Documentation](https://docs.getutm.app/)

## 適用した処理

1. Virtual Boxから新規仮想マシンを作成、メモリやCPUコア数の割当をし、インストールメディアを初期状態としてインストールする。
2. 起動し、Debianのセットアップユーティリティに従ってセットアップを進める。その際に、ユーザーの作成やホスト名の設定、ディスクのパーティション分割、セットアップ時にインストールするソフトウェアの指定、アップデート先の設定などを行った。
3. セットアップが終了して起動し、パッケージのインストールを開始した。
