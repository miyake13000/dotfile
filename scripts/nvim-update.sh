#!/bin/bash

function main() {
    mkdir /tmp/nvim_download
    if ! nvim_download; then
        echo "failed to download neovim"
        rm -rf /tmp/nvim_dowload
        exit 1
    fi

    if command -v nvim; then
        if is_latest; then
            echo "neovim is latest version"
            rm -rf /tmp/nvim_download
            exit
            true
        fi
    fi

    if ! install; then
        echo "failed to install neovim"
        rm -rf /tmp/nvim_download
        exit 1
    fi

    rm -rf /tmp/nvim_download
}

function nvim_download() {
    echo "downloading nvim..."
    wget -q -P /tmp/nvim_download "https://github.com/neovim/neovim/releases/download/stable/nvim.appimage" > /dev/null
    chmod +x /tmp/nvim_download/nvim.appimage > /dev/null
    echo "done."
}

function is_latest() {
    local_version=$(nvim --version | head -n 1)
    echo "local version = $local_version"
    download_version=$(/tmp/nvim_download/nvim.appimage --version | head -n 1)
    echo "download version = $download_version"
    [ "$local_version" = "$download_version" ]
}

function install() {
    echo "installing nvim..."
    mv /tmp/nvim_download/nvim.appimage ~/.local/bin/nvim
    echo "done."
}

main
