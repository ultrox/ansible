SHELL := /bin/bash
.POSIX:
# .PHONY: help

# Thanks: https://github.com/dannyZyg/dzk-bootstrap/blob/main/Makefile
help: ## Show this help
	@egrep -h '\s##\s' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

docker-build: ## Build the ubuntu docker container
	docker build -t ubuntu .

docker-run: ## Enter the ubuntu docker container
	docker run -it --rm -u ultrox ubuntu bash

docker-reload:
	make docker-build && make docker-run

docker-refresh:
	docker build --no-cache -t ubuntu . && make docker-run

all: ## Run the full ansible playbook
	ansible-playbook local.yml --ask-vault-pass --ask-become-pass

zsh: ## Install zsh
	ansible-playbook local.yml -t zsh --ask-become-pass

node: ## Install Node, N and a version of node with N
	ansible-playbook local.yml -t node

npm: ## Install npm packages
	ansible-playbook local.yml -t npm

node-npm: ## Install Node, N and npm packages
	ansible-playbook local.yml -t node,npm --ask-become-pass

vim: ## Install vim and plugins
	ansible-playbook local.yml -t nvim --ask-become-pass

ssh: ## Install existing ssh key
	ansible-playbook local.yml -t ssh --ask-vault-pass --ask-become-pass

ssh-seal: 
	ansible-vault encrypt --vault-id SSH@prompt ./.ssh/*

ssh-gen: ## Gen ssh key
	ssh-keygen -o -a 100 -t ed25519 -f /tmp/id_rsa -C "this is ultrox main" -q -N ""

dotfiles: ## Install dotfiles
	ansible-playbook local.yml -t dotfiles --ask-vault-pass --ask-become-pass

yay: ## Install yay packages
	ansible-playbook local.yml -t yay --ask-become-pass

espanso-unpack: ## Decrypt espanso repo files into the config path
	ansible-playbook local.yml -t espanso --ask-vault-pass

espanso-pack: ## Encrypt the system espanso files - overwrites repo files
	./scripts/encrypt-espanso-conf.sh

debug: ## Print out env vars
	ansible-playbook local.yml -t debug

ansible-kickoff: ## Adds ansible & stuff related for it to work
	./scripts/setup-ansible

clean-env:
	./scripts/clean-env
