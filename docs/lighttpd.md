## 概要

## インストール方法

```sh
sudo apt update
sudo apt install lighttpd lighttpd-doc
```

[WikiStart - Lighttpd - lighty labs](https://redmine.lighttpd.net/projects/lighttpd/wiki#Get-Lighttpd)

[Home - lighty news](https://www.lighttpd.net/)

### php

```sh
sudo apt update
sudo apt install php-fpm
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

## 追加

TODO: CGIについて調べる

[CGIってなんじゃ #Web - Qiita](https://qiita.com/_lvyuu/items/a90652cad440fdee21e8)

## トラブルシューティング

### ポートを8080にする

デフォルトのHTTPのポート80がすでに利用されているなどの理由で、仮想マシンとのPort Forwardingがうまく行かない場合がある。この場合、ポートをゲスト 80:8080 ホストのように紐付けをするとうまく行く場合がある。

###
