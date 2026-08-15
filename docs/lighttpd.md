## lighttpdについて

### インストール方法

#### lighttpd

```sh
sudo apt update
sudo apt install lighttpd lighttpd-doc
```

[WikiStart - Lighttpd - lighty labs](https://redmine.lighttpd.net/projects/lighttpd/wiki#Get-Lighttpd)

[Home - lighty news](https://www.lighttpd.net/)

##### PHPのサポート用のパッケージ

また、PHPを利用するためには、外部のパッケージをインストールする必要がある。

その際に利用されるのがCGIという仕組みであり、これを利用することで別のパッケージを利用してPHPコードを実行し、その結果をlighttpdを通してユーザーに返すことができる。

[CGIってなんじゃ #Web - Qiita](https://qiita.com/_lvyuu/items/a90652cad440fdee21e8)

```sh
sudo apt update
sudo apt install php-fpm
```

#### 設定

lighttpd

### 構成

#### サーブするディレクトリ

今回は、`/srv/`ディレクトリを利用するこの構成を活用しつつ、互換性を保つために、`/var/www`を`/srv/www`にシンボリックリンクをした。

```sh
sudo ln -s /src/www /var/www # 元 -> 先
```

[Linux入門：シンボリックリンクの基本と活用術をわかりやすく解説してみた #Linuxコマンド - Qiita](https://qiita.com/free-honda/items/9ca5e6f2e6079b653277)

[php - What is /var/www/html? - Stack Overflow](https://stackoverflow.com/questions/16197663/what-is-var-www-html)

[Linux FHS: /srv vs /var ... where do I put stuff? - Server Fault](https://serverfault.com/questions/124127/linux-fhs-srv-vs-var-where-do-i-put-stuff)

## トラブルシューティング

### VirtualBoxのPort Forwardingの設定

Virtual MachineのNetwork設定から、ポートフォワーディングが適切に設定されているか確認する。

### ポートを8080にする

デフォルトのHTTPのポート80がすでに利用されているなどの理由で、仮想マシンとのPort Forwardingがうまく行かない場合がある。この場合、ポートを `ゲスト 80:8080 ホスト` のように紐付けをするとうまく行く場合がある。
