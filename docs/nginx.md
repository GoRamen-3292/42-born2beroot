# nginx

## インストール

[nginx: Linux packages](https://nginx.org/en/linux_packages.html#Debian)

公式サイトの指示に従う。

手動でパッケージリストを追加して、nginxをインストールする。そうすることで、最新の安定版のリリースを使用することができる。

```sh
sudo apt install curl gnupg2 ca-certificates lsb-release debian-archive-keyring

curl https://nginx.org/keys/nginx_signing.key | gpg --dearmor \
    | sudo tee /usr/share/keyrings/nginx-archive-keyring.gpg >/dev/null
```

## 構成

### サーブするディレクトリ

今回は、`/srv/`ディレクトリを利用するこの構成を活用しつつ、互換性を保つために、`/var/www`を`/srv/www`にシンボリックリンクをした。

```sh
sudo ln -s /src/www /var/www # 元 -> 先
```

[Linux入門：シンボリックリンクの基本と活用術をわかりやすく解説してみた #Linuxコマンド - Qiita](https://qiita.com/free-honda/items/9ca5e6f2e6079b653277)

[php - What is /var/www/html? - Stack Overflow](https://stackoverflow.com/questions/16197663/what-is-var-www-html)

[Linux FHS: /srv vs /var ... where do I put stuff? - Server Fault](https://serverfault.com/questions/124127/linux-fhs-srv-vs-var-where-do-i-put-stuff)
