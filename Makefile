ISUCON := isucon8
REMOTE_PROJECT_NAME := torb

LOCAL_PROJECT_DIR := ../$(ISUCON)
REPO := git@github.com:AkashiSN/$(ISUCON).git

init: download push create-repo

.PHONY: download
download:
	ssh -F ssh_config isucon_app --  "tar -cvzf tarball.tar.gz $(REMOTE_PROJECT_NAME)/"
	scp -r -F ssh_config isucon_app:tarball.tar.gz .
	tar xvf tarball.tar.gz
	mv $(REMOTE_PROJECT_NAME) $(LOCAL_PROJECT_DIR)
	rm -rf tarball.tar.gz

.PHONY: push
push:
	cd $(LOCAL_PROJECT_DIR); echo ".bundle" > .gitignore
	cd $(LOCAL_PROJECT_DIR); echo "/webapp/go" >> .gitignore
	cd $(LOCAL_PROJECT_DIR); echo "/webapp/nodejs" >> .gitignore
	cd $(LOCAL_PROJECT_DIR); echo "/webapp/perl" >> .gitignore
	cd $(LOCAL_PROJECT_DIR); echo "/webapp/php" >> .gitignore
	cd $(LOCAL_PROJECT_DIR); echo "/webapp/python" >> .gitignore
	cd $(LOCAL_PROJECT_DIR); git init
	cd $(LOCAL_PROJECT_DIR); git add --a
	cd $(LOCAL_PROJECT_DIR); git commit -m "init"
	cd $(LOCAL_PROJECT_DIR); git remote add origin $(REPO)
	cd $(LOCAL_PROJECT_DIR); git push -u origin master

.PHONY: create-repo
create-repo:
	ssh -F ssh_config isucon_app -- "mkdir -p .ssh"
	ssh -F ssh_config isucon_app -- "chmod 700 .ssh"
	scp -r -F ssh_config ./deploy_key isucon_app:.ssh/deploy_key
	scp -r -F ssh_config ./ssh_config_remote isucon_app:.ssh/config
	ssh -F ssh_config isucon_app -- "chmod 600 .ssh/*"
	ssh -F ssh_config isucon_app -- "cd $(REMOTE_PROJECT_NAME)&& git init"
	ssh -F ssh_config isucon_app -- "cd $(REMOTE_PROJECT_NAME)&& git remote add origin $(REPO)"
	ssh -F ssh_config isucon_app -- "cd $(REMOTE_PROJECT_NAME)&& git pull origin master" 2>/dev/null; true
