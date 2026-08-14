## SSH

### 設定ファイル

`/etc/ssh/sshd_config` を編集

### 変更箇所

```
Port 4242

...

PermitRootLogin no
```

公開鍵認証などを設定するための要素はなかったので、このままにする
