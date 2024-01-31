CWD = $(shell pwd)

BINSTALL_INSTALL = curl -L --proto '=https' --tlsv1.2 -sSf https://raw.githubusercontent.com/cargo-bins/cargo-binstall/main/install-from-binstall-release.sh | bash
BINSTALL_PATH = $(shell which cargo-binstall || echo ~/.cargo/bin/cargo-binstall)
BINSTALL = $(BINSTALL_PATH) --no-confirm

usage:
	@echo "Setup script for miyake13000's dotfiles' (https://github.com/miyake13000/dotfiles)"
	@echo
	@echo "This Makefile can setup/update some tools"
	@echo "--------------------------------------------------------"
	@echo "Execute 'make setup' to update / 'make update' to update"
	@echo "--------------------------------------------------------"
	@echo "Or you can setup/update each tools individually"
	@echo "  zsh    (make setup-zsh  / update-zsh)"
	@echo "  nvim   (make setup-nvim / update-nvim)"
	@echo "  tmux   (make setup-tmux / no need to update)"
	@echo "  anyenv (make setup-lang / update-lang)"
	@echo "  git    (make setup-git  / update-git)"
	@echo

check-command:
	@which git    > /dev/null || (echo "Install git"    ; exit 1)
	@which curl   > /dev/null || (echo "Install curl"   ; exit 1)
	@which tar    > /dev/null || (echo "Install tar"    ; exit 1)
	@which gunzip > /dev/null || (echo "Install gunzip" ; exit 1)
	@which zsh    > /dev/null || (echo "Install zsh"    ; exit 1)
	@which tmux   > /dev/null || (echo "Install tmux"   ; exit 1)
	@[ -e $(BINSTALL_PATH) ] > /dev/null || $(BINSTALL_INSTALL)

setup: setup-zsh setup-nvim setup-tmux setup-git setup-lang

setup-zsh: check-command
	mkdir -p ~/.config
	mkdir -p ~/.config/sheldon
	mkdir -p ~/.local/bin
	ln -sf $(CWD)/zsh/zshrc ~/.zshrc
	ln -sf $(CWD)/zsh/starship.toml ~/.config/starship.toml
	ln -sf $(CWD)/zsh/plugins.toml ~/.config/sheldon/plugins.toml
	$(BINSTALL) sheldon
	$(BINSTALL) starship
	$(CWD)/scripts/install-tools.sh fzf

setup-nvim: check-command
	mkdir -p ~/.config/nvim
	mkdir -p ~/.local/bin
	mkdir -p ~/.local/share/nvim
	ln -sf $(CWD)/vim/init.lua ~/.config/nvim/init.lua
	ln -sf $(CWD)/vim/snip ~/.local/share/nvim/
	ln -sf $(CWD)/scripts/nvim-update.sh ~/.local/bin/nvim-update
	ln -sf $(CWD)/scripts/ggr.sh ~/.local/bin/ggr
	$(CWD)/scripts/nvim-update.sh --force
	$(BINSTALL) bat
	$(BINSTALL) fd-find
	$(BINSTALL) ripgrep
	$(CWD)/scripts/install-tools.sh tree-sitter
	$(CWD)/scripts/install-tools.sh lazygit

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

setup-git: check-command
	cat $(CWD)/git/gitconfig >> ~/.gitconfig
	$(BINSTALL) git-delta

update: update-zsh update-nvim update-lang update-git

update-zsh: check-command
	mkdir -p ~/.local/bin
	$(BINSTALL) sheldon
	$(BINSTALL) starship
	$(CWD)/scripts/install-tools.sh fzf

update-nvim: check-command
	mkdir -p ~/.local/bin
	$(CWD)/scripts/nvim-update.sh --force
	$(BINSTALL) bat
	$(BINSTALL) fd-find
	$(BINSTALL) ripgrep
	$(CWD)/scripts/install-tools.sh tree-sitter
	$(CWD)/scripts/install-tools.sh lazygit

update-lang:;	anyenv update

update-git: check-command
	$(BINSTALL) git-delta

