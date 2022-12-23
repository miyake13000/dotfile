CWD = $(shell pwd)

usage:
	@echo "dotfiles for miyake13000 (https://github.com/miyake13000)"
	@echo ""
	@echo "This Makefile can setup/update below tools"
	@echo "  zsh"
	@echo "  nvim"
	@echo "  tmux"
	@echo "  anyenv (some languages' environment)"
	@echo "You can setup above tools with below command"
	@echo "  zsh    -> make setup-zsh"
	@echo "  nvim   -> make setup-nvim"
	@echo "  tmux   -> make setup-tmux"
	@echo "  anyenv -> make setup-lang"
	@echo "  above all -> setup-all"
	@echo "You can also update them"
	@echo "  zsh    -> make update-zsh"
	@echo "  nvim   -> make update-nvim"
	@echo "  tmux   -> make update-tmux"
	@echo "  anyenv -> make update-lang"
	@echo "  above all -> update-all"

check-command:
	@which git
	@which wget
	@which curl
	@which tar
	@which gunzip

setup-all: setup-zsh setup-nvim setup-tmux setup-git setup-lang

setup-zsh: check-command
	mkdir -p ~/.zsh
	mkdir -p ~/.config
	mkdir -p ~/.local/bin
	ln -sf $(CWD)/zsh/zshrc ~/.zshrc
	ln -sf $(CWD)/zsh/starship.toml ~/.config/starship.toml
ifeq ("$(wildcard ~/.zsh/completions)", "")
	git clone -q https://github.com/zsh-users/zsh-completions ~/.zsh/completions
endif
ifeq ("$(wildcard ~/.zsh/autosuggestions)", "")
	git clone -q https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/autosuggestions
endif
	$(CWD)/scripts/install-tools.sh starship

setup-nvim: check-command
	mkdir -p ~/.config/nvim
	mkdir -p ~/.local/bin
	mkdir -p ~/.vim
	ln -sf $(CWD)/vim/init.vim ~/.config/nvim/init.vim
	ln -sf $(CWD)/vim/snip ~/.vim/snip
	ln -sf $(CWD)/scripts/nvim-update.sh ~/.local/bin/nvim-update
	ln -sf $(CWD)/scripts/ggr.sh ~/.local/bin/ggr
	$(CWD)/scripts/nvim-update.sh
	$(CWD)/scripts/install-tools.sh bat
	$(CWD)/scripts/install-tools.sh fd
	$(CWD)/scripts/install-tools.sh rg
	$(CWD)/scripts/install-tools.sh shellcheck
	$(CWD)/scripts/install-tools.sh tree-sitter

setup-tmux: check-command
	ln -sf $(CWD)/tmux/tmux.conf ~/.tmux.conf


setup-lang: check-command
ifeq ("$(wildcard ~/.anyenv)", "")
	git clone -q https://github.com/anyenv/anyenv ~/.anyenv
endif
ifeq ("$(wildcard ~/.anyenv/plugins)", "")
	git clone -q https://github.com/znz/anyenv-update.git ~/.anyenv/plugins/anyenv-update
endif
	ln -sf ~/.anyenv/bin/anyenv ~/.local/bin/anyenv
	~/.anyenv/bin/anyenv install --force-init
	~/.anyenv/bin/anyenv install rbenv
	~/.anyenv/bin/anyenv install pyenv
	~/.anyenv/bin/anyenv install nodenv

setup-git: check-command
	mkdir -p ~/.local/bin
	cat $(CWD)/git/gitconfig >> ~/.gitconfig
	$(CWD)/scripts/install-tools.sh delta

update-all: update-zsh update-nvim update-lang

update-zsh: check-command
	cd ~/.zsh/completions && git pull -q origin master
	cd ~/.zsh/autosuggestions && git pull -q origin master
	$(CWD)/scripts/install-tools.sh starship

update-nvim: check-command
	$(CWD)/scripts/nvim-update.sh
	$(CWD)/scripts/install-tools.sh bat
	$(CWD)/scripts/install-tools.sh fd
	$(CWD)/scripts/install-tools.sh rg
	$(CWD)/scripts/install-tools.sh shellcheck
	$(CWD)/scripts/install-tools.sh tree-sitter

update-lang:;	anyenv update

