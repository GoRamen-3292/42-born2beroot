## Groups

### 方法

前提: `/etc/group` を変更しても結果的に同じことができるが、コマンド経由でやることを推奨

`gpasswd` コマンドなど、方法も色々ある

### 確認

`groups` コマンドで現在ユーザーが所属するグループを確認

### グループの...

#### 追加

`groupadd user42` のようにしてグループを追加

#### 削除

`groupdel groupname`

### ユーザーの...

#### 追加

`usermod -aG groupname username`
`usermod -a -G groupname username`

- `-a`: Appendする
- `-G groupname` groupnameを追加する

[Groups Command in Linux - GeeksforGeeks](https://www.geeksforgeeks.org/linux-unix/groups-command-in-linux-with-examples/)

### 削除

`deluser username groupname`
