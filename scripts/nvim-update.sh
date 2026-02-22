#!/bin/bash

function set_options(){
    while getopts "fn-:" OPT; do
        case $OPT in
            -)
                case "${OPTARG}" in
                    force)
                        FORCE=true
                        ;;
                    nightly)
                        NIGHTLY=true
                        ;;
                    *)
                        echo "Invalid option: $OPT"
                        exit 1
                ;;
                esac
                ;;
            f)
                FORCE=true
                ;;
            n)
                NIGHTLY=true
                ;;
            *)
                echo "Invalid option: $OPT"
                exit 1
                ;;
        esac
    done
}

function main() {
    set_options "$@"
    if [[ -v NIGHTLY ]]; then
        tag="nightly"
    else
        tag="stable"
    fi
    source="/tmp/nvim-download/nvim-$tag"
    dest="$HOME/.local/bin/nvim-$tag"

    mkdir -p "$(dirname $source)" &>/dev/null
    download_nvim "$tag" "$source"
    print_nvim_version "$source"

    if ! [[ -v FORCE ]]; then
        if ! ensure_installation "$source"; then
            echo "Installation aborted."
            rm -rf "$(dirname $source)"
            exit 1
        fi
    fi

    mkdir -p "$(dirname $dest)" &>/dev/null
    if ! install_nvim "$tag" "$path" "$dest"; then
        echo "failed to install neovim"
        rm -rf "$(dirname $source)"
        exit 1
    fi

    if ! update_plugins; then
        echo "failed to update plugins"
        exit 1
    fi

    rm -rf "$(dirname $source)"
}

function download_nvim() {
    tag=$1
    path="$2"
    echo -n "Downloading nvim-$tag..."
    curl -s -L "https://github.com/neovim/neovim/releases/download/$tag/nvim-$(uname -s)-$(uname -m).appimage" > "$path"
    chmod +x "$path" > /dev/null
    echo "done."
    echo
}

function print_nvim_version() {
    path="$1"
    if which nvim > /dev/null; then
        current_version="$(nvim --version | head -n 1)"
        echo "Current nvim version: $current_version"
    fi
    download_version="$($path --version | head -n 1)"
    echo "New nvim version: $download_version"
    echo
}

function ensure_installation() {
    path="$1"
    echo "Current nvim will be overwritten by new nvim."
    echo "Do you want to continue to install?"
    echo -n "[Y/n]: "
    read res
    echo
    if [ "$res" = "n" ] || [ "$res" = "N" ]; then
        return 1
    else
        return 0
    fi
}

function install_nvim() {
    tag=$1
    src="$2"
    dest="$3"
    link="$(dirname $3)/nvim"
    filename="$(basename $3)"
    echo -n "Installing nvim..."
    mv "$src" "$dest"
    ln -fs "$filename" "$link"
    echo "done."
    echo
}

function update_plugins() {
    echo -n "Updating plugins..."
    nvim --headless "+Lazy! sync" +qa
    echo "done."
    echo
}

main "$@"
