# isucon-ansible

## 準備

1. `ISUCON`用のリポジトリを作成して　
`Makefile`の`ISUCON`を書き換えておく

2. `deploy_key`というファイル名でデプロイキーを用意する（GitHubのリポジトリにも登録しておく）

3. `private_key`というファイル名ですべてのサーバーに接続する秘密鍵を置く

4. `hosts_vars/isucon_[app,redis].yaml`に以下の内容のファイルを作成
```yaml
ansible_sudo_pass: ユーザーパスワード
```
`hosts_vars/isucon_db.yaml`に以下の内容のファイルを作成
```yaml
ansible_sudo_pass: ユーザーパスワード
database_password: データベースのパスワード
database_root_password: データベースのrootパスワード
```

5. `ssh_config`の内容を環境に合わせて修正
```conf
Host isucon_app
    HostName              IPアドレス等
    User                  isucon
    IdentityFile          private_key
    IdentitiesOnly        yes
    StrictHostKeyChecking no
    UserKnownHostsFile    /dev/null

Host isucon_db
    HostName              IPアドレス等
    User                  isucon
    IdentityFile          private_key
    IdentitiesOnly        yes
    StrictHostKeyChecking no
    UserKnownHostsFile    /dev/null

Host isucon_redis
    HostName              IPアドレス等
    User                  isucon
    IdentityFile          private_key
    IdentitiesOnly        yes
    StrictHostKeyChecking no
    UserKnownHostsFile    /dev/null
```

6. `make init`を実行してアプリケーションをGitHubにpush & すべてのサーバー側のリポジトリをpullする

7. 対象サーバーに入って不要なアプリケーションを削除する

## プロビジョニング

```bash
$ make provision
```

3台構成

- App Server (nginx + ruby)
- DataBase Server (mysql)
- Redis Server (Redis)

手動でやるべきこと, 
- `/etc/systemd/system/*.service` の実行パスを変更する (`isucon_app`)
- `mysql`の初期データを挿入する (アカウント情報は`host_vars/isucon_db.yaml`に書いてある) (`isucon_db`)


## Install netdata
```bash
$ bash <(curl -Ss https://my-netdata.io/kickstart.sh)
$ sudo systemctl start netdata
```