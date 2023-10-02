#!/bin/bash

set -e -o pipefail

if [ "$1" = "" ]; then
    cat - << _EOT_
    install-tools.sh <tool-name>

    tool-name:
    bat           cat alternative
    delta         diff alternative
    fd            find alternative
    rg            grep alternative
    shellcheck    syntax parser for shell script
    starship      shell prompt customizer
    tree-sitter   syntax parser
    lazygit       CUI git integrator

    all           install above tools at once
_EOT_
    exit
fi

mkdir -p /tmp/install-tools/
cd /tmp/install-tools

if [ "$1" = "bat" ] || [ "$1" = "all" ]; then
    bat_version=$(curl -Ls https://github.com/sharkdp/bat/releases/latest | grep "<title>"  | awk '{print $2}')
    echo "Installing bat (${bat_version})..."
    wget -q https://github.com/sharkdp/bat/releases/download/${bat_version}/bat-${bat_version}-x86_64-unknown-linux-musl.tar.gz > /dev/null
    tar xzf bat-${bat_version}-x86_64-unknown-linux-musl.tar.gz > /dev/null
    mv bat-${bat_version}-x86_64-unknown-linux-musl/bat ~/.local/bin/bat > /dev/null
    echo "done"
fi

if [ "$1" = "delta" ] || [ "$1" = "all" ]; then
    delta_version=$(curl -Ls https://github.com/dandavison/delta/releases/latest | grep "<title>"  | awk '{print $2}')
    echo "Installing delta (${delta_version})..."
    wget -q https://github.com/dandavison/delta/releases/download/${delta_version}/delta-${delta_version}-x86_64-unknown-linux-musl.tar.gz > /dev/null
    tar xzf delta-${delta_version}-x86_64-unknown-linux-musl.tar.gz > /dev/null
    mv delta-${delta_version}-x86_64-unknown-linux-musl/delta ~/.local/bin/delta > /dev/null
    echo "done"
fi

if [ "$1" = "fd" ] || [ "$1" = "all" ]; then
    fd_version=$(curl -Ls https://github.com/sharkdp/fd/releases/latest | grep "<title>"  | awk '{print $2}')
    echo "Installing fd (${fd_version})..."
    wget -q https://github.com/sharkdp/fd/releases/download/${fd_version}/fd-${fd_version}-x86_64-unknown-linux-musl.tar.gz > /dev/null
    tar xzf fd-${fd_version}-x86_64-unknown-linux-musl.tar.gz > /dev/null
    mv fd-${fd_version}-x86_64-unknown-linux-musl/fd ~/.local/bin/fd > /dev/null
    echo "done"
fi

if [ "$1" = "rg" ] || [ "$1" = "all" ]; then
    rg_version=$(curl -Ls https://github.com/BurntSushi/ripgrep/releases/latest | grep "<title>"  | awk '{print $2}')
    echo "Installing rg (${rg_version})..."
    wget -q https://github.com/BurntSushi/ripgrep/releases/download/${rg_version}/ripgrep-${rg_version}-x86_64-unknown-linux-musl.tar.gz > /dev/null
    tar xzf ripgrep-${rg_version}-x86_64-unknown-linux-musl.tar.gz > /dev/null
    mv ripgrep-${rg_version}-x86_64-unknown-linux-musl/rg ~/.local/bin/rg > /dev/null
    echo "done"
fi

if [ "$1" = "shellcheck" ] || [ "$1" = "all" ]; then
    redirect_url=$(curl -w "%{redirect_url}" -s -o /dev/null https://github.com/koalaman/shellcheck/releases/latest/)
    version=$(echo $redirect_url | sed 's/\// /g' | awk '{print $NF}')
    shellcheck_filename=$(curl -Ls https://github.com/koalaman/shellcheck/releases/expanded_assets/$version | grep "linux.x86_64" | grep "span" | sed -E 's/^ *<[^<]*>//' | sed -E 's/<.*>$//')
    echo "Installing shellcheck..."
    wget -q https://github.com/koalaman/shellcheck/releases/latest/download/${shellcheck_filename} > /dev/null
    mkdir shellcheck > /dev/null
    tar xf ${shellcheck_filename} -C shellcheck --strip-components 1 > /dev/null
    mv shellcheck/shellcheck ~/.local/bin/shellcheck > /dev/null
    echo "done"
fi

if [ "$1" = "starship" ] || [ "$1" = "all" ]; then
    echo "Installing starship..."
    wget -q https://github.com/starship/starship/releases/latest/download/starship-x86_64-unknown-linux-musl.tar.gz > /dev/null
    tar xzf starship-x86_64-unknown-linux-musl.tar.gz > /dev/null
    mv starship ~/.local/bin/starship > /dev/null
    echo "done"
fi

if [ "$1" = "tree-sitter" ] || [ "$1" = "all" ]; then
    echo "Installing tree-sitter..."
    wget -q https://github.com/tree-sitter/tree-sitter/releases/latest/download/tree-sitter-linux-x64.gz > /dev/null
    gunzip tree-sitter-linux-x64.gz > /dev/null
    chmod +x tree-sitter-linux-x64 > /dev/null
    mv tree-sitter-linux-x64 ~/.local/bin/tree-sitter > /dev/null
    echo "done"
fi

if [ "$1" = "lazygit" ] || [ "$1" = "all" ]; then
    lazygit_version=$(curl -Ls https://github.com/jesseduffield/lazygit/releases/latest | grep "<title>"  | awk '{print $2}')
    lazygit_version_stripped="${lazygit_version:1}"
    echo "Installing lazygit (${lazygit_version})..."
    wget -q https://github.com/jesseduffield/lazygit/releases/download/${lazygit_version}/lazygit_${lazygit_version_stripped}_Linux_x86_64.tar.gz > /dev/null
    tar xzf lazygit_${lazygit_version_stripped}_Linux_x86_64.tar.gz > /dev/null
    mv lazygit ~/.local/bin/lazygit > /dev/null
    echo "done"
fi

if [ "$1" = "fzf" ] || [ "$1" = "all" ]; then
    fzf_version=$(curl -Ls https://github.com/junegunn/fzf/releases/latest | grep "<title>"  | awk '{print $2}')
    echo "Installing fzf (${fzf_version})..."
    wget -q https://github.com/junegunn/fzf/releases/download/${fzf_version}/fzf-${fzf_version}-linux_amd64.tar.gz > /dev/null
    tar xzf fzf-${fzf_version}-linux_amd64.tar.gz > /dev/null
    mv fzf ~/.local/bin/fzf > /dev/null
    echo "done"
fi

if [ "$1" = "tmux" ] || [ "$1" = "all" ]; then
    tmux_version=$(curl -Ls https://github.com/nelsonenzo/tmux-appimage/releases/latest | grep "<title>" | awk '{print $3}')
    echo "Installing tmux (${tmux_version})..."
    wget -q https://github.com/nelsonenzo/tmux-appimage/releases/latest/download/tmux.appimage > /dev/null
    chmod +x tmux.appimage
    mv tmux.appimage ~/.local/bin/tmux > /dev/null
    echo "done"
fi

rm -r /tmp/install-tools
