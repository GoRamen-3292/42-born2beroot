## Docker

Dockerとは、コンテナ仮想化のソフトの1つである。これをインストールすることで、

### インストール方法

ドキュメントをコピー&ペーストして実行しました。具体的には、公式のaptリポジトリの取得先から、Dockerをインストールするという作業をしています。

[Install Docker Engine on Debian | Docker Docs](https://docs.docker.com/engine/install/debian/)

### なぜインストールしたのか

- DockerにはDaemonが必要で、そのデーモンは`a service`の要件を満たせるから
- ソフトウェア開発のツールとして、広く使用されているから
  - 例: 複雑な環境構築なしに、dockerのコマンドを実行するだけで仮想環境上に環境構築してソフトウェアが実行されている状態を作成することができる