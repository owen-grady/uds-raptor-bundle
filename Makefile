RKE2_VERSION = v1.28.4+rke2r1

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

download-rke2-tarballs:
	curl -o $(CURDIR)/rke2-ansible/tarball_install/rke2-images.linux-amd64.tar.zst -Ls https://github.com/rancher/rke2/releases/download/$$RKE2_VERSION/rke2-images.linux-amd64.tar.zst
	curl -o $(CURDIR)/rke2-ansible/tarball_install/rke2.linux-amd64.tar.gz -Ls https://github.com/rancher/rke2/releases/download/$$RKE2_VERSION/rke2.linux-amd64.tar.gz
	curl -o $(CURDIR)/rke2-ansible/tarball_install/sha256sum-amd64.txt -Ls https://github.com/rancher/rke2/releases/download/$$RKE2_VERSION/sha256sum-amd64.txt

rke2-edn-install: git-sub-module ## Install RKE2 into the EDN environment
	@(export ANSIBLE_CONFIG=$(CURDIR)/ansible/ansible.cfg; \
	export ANSIBLE_INVENTORY=$(CURDIR)/ansible/edn-inventory.yaml; \
	ansible-playbook -b -k -K -i "$$ANSIBLE_INVENTORY" $(CURDIR)/rke2-ansible/site.yml)

rke2-edn-uninstall:
