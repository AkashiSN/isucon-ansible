# isucon-ansible

`hosts`ファイルを以下で作成
```ini
[isucon_server]
isucon
```

`private_key`というファイル名で秘密鍵を置く

`hosts_vars/isucon.yaml`に以下の内容のファイルを作成
```yaml
ansible_sudo_pass: パスワード
```

`ssh_conf`の内容を環境に合わせて作成
```conf
Host isucon
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
