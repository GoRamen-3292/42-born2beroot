## 概要

TODO: 追記する

## インストール方法

```bash
sudo apt update
sudo apt install lighttpd lighttpd-doc
```

[WikiStart - Lighttpd - lighty labs](https://redmine.lighttpd.net/projects/lighttpd/wiki#Get-Lighttpd)

[Home - lighty news](https://www.lighttpd.net/)

### php

```bash
sudo apt update
sudo apt install php-fpm
```

## トラブルシューティング

### ポートを8080にする

デフォルトのHTTPのポート80がすでに利用されているなどの理由で、仮想マシンとのPort Forwardingがうまく行かない場合がある。この場合、ポートをゲスト 80:8080 ホストのように紐付けをするとうまく行く場合がある。

### 
