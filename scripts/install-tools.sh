#!/bin/bash

set -e -o pipefail

if [ "$1" = "" ]; then
    cat - << _EOT_
    install-tools.sh <tool-name>

    tool-name:
    tree-sitter   syntax parser
    lazygit       CUI git integrator

    all           install above tools at once
_EOT_
    exit
fi

mkdir -p /tmp/install-tools/
cd /tmp/install-tools

if [ "$1" = "tree-sitter" ] || [ "$1" = "all" ]; then
    echo "Installing tree-sitter..."
    curl -Ls https://github.com/tree-sitter/tree-sitter/releases/latest/download/tree-sitter-linux-x64.gz > tree-sitter-linux-x64.gz
    gunzip tree-sitter-linux-x64.gz > /dev/null
    chmod +x tree-sitter-linux-x64 > /dev/null
    mv tree-sitter-linux-x64 ~/.local/bin/tree-sitter > /dev/null
    echo "done"
fi

if [ "$1" = "lazygit" ] || [ "$1" = "all" ]; then
    lazygit_version=$(curl -Ls https://github.com/jesseduffield/lazygit/releases/latest | grep "<title>"  | awk '{print $2}')
    lazygit_version_stripped="${lazygit_version:1}"
    echo "Installing lazygit (${lazygit_version})..."
    curl -Ls https://github.com/jesseduffield/lazygit/releases/download/${lazygit_version}/lazygit_${lazygit_version_stripped}_Linux_x86_64.tar.gz > lazygit.tar.gz
    tar xzf lazygit.tar.gz > /dev/null
    mv lazygit ~/.local/bin/lazygit > /dev/null
    echo "done"
fi

rm -r /tmp/install-tools
