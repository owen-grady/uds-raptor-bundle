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

rke2-edn-install: git-sub-module
	@(export ANSIBLE_CONFIG=$(CURDIR)/ansible/ansible.cfg; \
	export ANSIBLE_INVENTORY=$(CURDIR)/ansible/edn-inventory.yaml; \
	ansible-playbook -b -k -K -i "$$ANSIBLE_INVENTORY" $(CURDIR)/rke2-ansible/site.yml)
