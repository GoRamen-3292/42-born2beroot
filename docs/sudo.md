# sudo

## インストール

Rootで以下のコマンドを実行

```
apt install sudo
```

## 使用方法

[【Linux入門】sudoを完全に理解する。仕組み・使い方。そして3つの責任 #Linux - Qiita](https://qiita.com/Shiro_Shihi/items/f34c1aa7bb1cb5118c70)

1. インストール
2. デフォルトの設定で `sudo` グループに属する人が利用可能になっているのでグループを追加

## 設定方法

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

## 詳細

### pty vs tty

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

TODO: 違いを調べる

pc 昔

データを1文字ずつ入力、物理的に1文字ずつ入力する時代があった

これがそのままプロトコルに?
