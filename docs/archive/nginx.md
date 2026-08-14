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
