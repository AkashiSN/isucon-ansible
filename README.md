# isucon-ansible

`hosts`ファイルを以下で作成
```ini
[isucon_app_server]
isucon_app

[isucon_db_server]
isucon_db

[isucon_redis_server]
isucon_redis
```

`private_key`というファイル名で秘密鍵を置く

`hosts_vars/isucon_[app,db,redis].yaml`に以下の内容のファイルを作成
```yaml
ansible_sudo_pass: パスワード
```

`ssh_conf`の内容を環境に合わせて作成
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

```bash
$ ansible-playbook site.yaml
```

## Install netdata
```bash
$ bash <(curl -Ss https://my-netdata.io/kickstart.sh)
$ sudo systemctl start netdata
```