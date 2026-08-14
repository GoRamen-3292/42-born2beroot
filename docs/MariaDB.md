## MariaDBについて

### インストール

公式サイトより、aptリポジトリを取得してMariaDBをインストールする。

直接 `sudo apt install mariadb-server` でインストールすることも可能だが、公式の手段に従うことでより確実に最新バージョンのものを利用することができる。

[Download MariaDB Server - MariaDB.org](https://mariadb.org/download/?t=mariadb&p=mariadb&r=12.3.2)

データベース設定は公式の手段に従って実施。当然、現時点ではローカルからしか接続をしないDBのポート開放などはしないように設定。

また、WordPressのインストール時に、MariaDBのユーザーを作成し権限を付与する必要がある。
