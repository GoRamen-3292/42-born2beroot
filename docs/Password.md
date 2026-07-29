# Password

## `pam-pwquality`

libpwqualityがまだインストールされていない場合、インストールする。

```bash
sudo apt install libpwquality
```

`/etc/pam.d/common-password` を編集する。

```bash
sudo vi /etc/pam.d/common-password
```

[pwquality.conf(5) - Linux man page](https://linux.die.net/man/5/pwquality.conf)
[libpwquality/libpwquality: Password quality checking library](https://github.com/libpwquality/libpwquality)

```bash
man 5 pwquality.conf
man 8 pam_pwquality
```

## `/etc/login.defs`

以下のように編集をする。

```txt
PASS_MAX_DAYS   30
```

こうすることで、30日後にパスワードを変更させられるようになる。

TODO: これを既存のユーザーに対して強制する方法

```bash
man 5 login.defs
```