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

このプロジェクトは校舎PCの、Ubuntu 22.04 LTS上で実行することを想定している。

---

## Resources

`man` コマンドについては、インストールした`Debian GNU/Linux 13.6 (trixie)`に内蔵されていたmanページを参照しました。

## AI Usage

- 検索の補助
- GitHub Copilotのコード補完機能によるMarkdown執筆の補助

のみに利用しました

---

## Project Description

### システムの違いについて

このセクションでは、"required additions"として課題で求められている「違い」を説明するべき項目について解説をする。

#### Debian vs Rocky Linux

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

#### AppArmor vs SELinux

AppArmorとは、ユーザーやグループによる権限管理だけではなく、実行ファイルごとに権限を分けることによってセキュリティの向上を図るものである。これは、`Application-Centric` と公式サイトに説明されている通りである。

一方で、SELinuxは、より広範な設定を可能にするものである。例えば、アプリケーションやプロセス、ファイルなどに対するアクセス制限が可能である。

どちらも、UNIXのシステムではDAC (任意アクセス制御)が採用されている中で、MAC(強制アクセス制御)を可能にするものである。つまり、sudoなどの権限を通して強制的に実行することができなくなるようにするもので、root以外権限設定を変更することができなくなるようにするものである。

[AppArmor #Security - Qiita](https://qiita.com/propella/items/a6b646916b48029c369e)

[SELinux とは？をわかりやすく解説](https://www.redhat.com/ja/topics/linux/what-is-selinux)

- [AppArmor Documentation - AppArmor](https://www.apparmor.net/)
- [AppArmor vs SELinux - AppArmor](https://www.apparmor.net/about/apparmor_vs_selinux/)

[DAC(任意アクセス制御)とMAC(強制アクセス制御)、RBAC(ロールベースアクセス制御)の違い #初心者 - Qiita](https://qiita.com/miyuki_samitani/items/acde77784237e482aef8)

#### UFW vs firewalld

Uncomplicated Firewall、通称UFWはnetfilter firewallを制御するものである。

firewalldもおおよそ同様なものであり、システムの制御をするためのものである。

どちらも、Linuxのシステム上で動作する、ファイアーウォールというネットワークにおいて外部からのアクセスなどを制限する仕組みである。

[ufw in Launchpad](https://launchpad.net/ufw)

[Home | firewalld](https://firewalld.org/)

[ファイアウォールとは? そのしくみと機能、役割について解説 - Microsoft for business](https://www.microsoft.com/ja-jp/area/biz/smb/column-firewall)

#### VirtualBox vs UTM

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

### Details

このセクションでは、自分が行ったデザインや、実装した機能について説明する。

---
