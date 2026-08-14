## Password

### `pam-pwquality`

libpwqualityがまだインストールされていない場合、インストールする。

```sh
sudo apt install libpwquality
```

以下の2ファイルを編集する

#### `/etc/pam.d/common-password`

```
password    requisite               pam_pwquality.so retry=3 minlen=10 ucredit=-1 ...
```

#### `/etc/security/pwquality.conf/`

```
difok = 7
```

[pwquality.conf(5) - Linux man page](https://linux.die.net/man/5/pwquality.conf)
[libpwquality/libpwquality: Password quality checking library](https://github.com/libpwquality/libpwquality)

```sh
man 5 pwquality.conf
man 8 pam_pwquality
```

#### `/etc/login.defs`

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
