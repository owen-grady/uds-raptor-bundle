CLUSTER_ENV ?= edn
RKE2_VERSION = v1.28.4+rke2r1
UDS_CLI_VERSION = v0.5.2

.PHONY: help h
h: help
help: ## Display this help information
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
	  | sort | awk 'BEGIN {FS = ":.*?## "}; \
	  {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

all: help

git-sub-module: ## Update git submodules
	git submodule update --init --recursive
	git submodule foreach git pull origin main

download-rke2-tarballs: ## Download RKE2 Installation Tarballs
	curl -o $(CURDIR)/rke2-ansible/tarball_install/rke2-images.linux-amd64.tar.zst -Ls https://github.com/rancher/rke2/releases/download/$(RKE2_VERSION)/rke2-images.linux-amd64.tar.zst
	curl -o $(CURDIR)/rke2-ansible/tarball_install/rke2.linux-amd64.tar.gz -Ls https://github.com/rancher/rke2/releases/download/$(RKE2_VERSION)/rke2.linux-amd64.tar.gz
	curl -o $(CURDIR)/rke2-ansible/tarball_install/sha256sum-amd64.txt -Ls https://github.com/rancher/rke2/releases/download/$(RKE2_VERSION)/sha256sum-amd64.txt

rke2-install: git-sub-module download-rke2-tarballs ## Install RKE2 into the EDN environment
	@(export ANSIBLE_CONFIG=$(CURDIR)/infra/ansible/ansible.cfg; \
	export ANSIBLE_INVENTORY=$(CURDIR)/infra/ansible/inventory-$(CLUSTER_ENV)/hosts.ini; \
	ansible-playbook -b -k -K -i "$$ANSIBLE_INVENTORY" $(CURDIR)/rke2-ansible/site.yml)

rook-ceph-cleanup:

rke2-edn-uninstall: rook-ceph-cleanup
	@(export ANSIBLE_CONFIG=$(CURDIR)/infra/ansible/ansible.cfg; \
	export ANSIBLE_INVENTORY=$(CURDIR)/ansible/edn-inventory.yaml; \
	ansible-playbook -b -k -K -i "$$ANSIBLE_INVENTORY" $(CURDIR)/infra/ansible/playbooks/uninstall.yml )

download-uds-cli: ## Download UDS CLI 
	curl -o $(CURDIR)/uds -Ls https://github.com/defenseunicorns/uds-cli/releases/download/$(UDS_CLI_VERSION)/uds-cli_$(UDS_CLI_VERSION)_Linux_amd64
	chmod +x $(CURDIR)/uds
	sudo mv $(CURDIR)/uds /usr/local/bin/

