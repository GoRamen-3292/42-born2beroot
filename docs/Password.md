# Password

## `pam-pwquality`

libpwqualityがまだインストールされていない場合、インストールする。

```sh
sudo apt install libpwquality
```

`/etc/pam.d/common-password` を編集する。

```sh
sudo vi /etc/pam.d/common-password
```

[pwquality.conf(5) - Linux man page](https://linux.die.net/man/5/pwquality.conf)
[libpwquality/libpwquality: Password quality checking library](https://github.com/libpwquality/libpwquality)

```sh
man 5 pwquality.conf
man 8 pam_pwquality
```

## `/etc/login.defs`

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

参考:

```bash
man 5 login.defs
```
