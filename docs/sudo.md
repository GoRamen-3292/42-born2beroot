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
# ptyからのsudoを禁ずる (=tty modeのみ)
Defaults use_pty
```

[【備忘録】linuxでsudoを安全に使うための設定](https://zenn.dev/taisei1/articles/962a84e1dbe3a2)
[How can I change the number of password entry attempts allowed by sudo? - Ask Ubuntu](https://askubuntu.com/questions/534868/how-can-i-change-the-number-of-password-entry-attempts-allowed-by-sudo)
[bash - sudo change default error message - Stack Overflow](https://stackoverflow.com/questions/41058328/sudo-change-default-error-message)
```bash
man sudoers
```
