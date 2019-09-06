# isucon-ansible

## 準備

1. `ISUCON`用のリポジトリを作成して　
`Makefile`の`ISUCON`を書き換えておく

2. `deploy_key`というファイル名でデプロイキーを用意する（GitHubのリポジトリにも登録しておく）

3. `private_key`というファイル名でサーバーに接続する秘密鍵を置く

4. `hosts_vars/isucon_[app,db,redis].yaml`に以下の内容のファイルを作成
```yaml
ansible_sudo_pass: パスワード
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

6. `make init`を実行してアプリケーションをGitHubにpush & サーバー側のリポジトリをpullする


## プロビジョニング

```bash
$ ansible-playbook site.yaml
```

## Install netdata
```bash
$ bash <(curl -Ss https://my-netdata.io/kickstart.sh)
$ sudo systemctl start netdata
```