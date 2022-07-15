## dot_files

### Setup

1. Install zsh, tmux, curl, wget, git, build-essential, gunzip
    ```bash
    sudo apt install zsh tmux curl wget git build-essential gzip
    ```

2. Clone this repository
    ```bash
    git clone https://github.com/miyake13000/setupper.git ~/.dot_files
    cd ~/.dot_files
    ```

3. Setup
    ```bash
    make setup-all
    ```
    (Optional)
    It is possible to setup individually.
    ```bash
    make setup-nvim
    ```

4. Change default shell
    ```bash
    chsh -s /bin/zsh
    ```

5. Reopen shell

6. Install Ruby, Python, Node.js

    (Note) Below version is a example.
    You should check available versions with `*env install -l` command.
    ```bash
    rbenv install 3.1.2 && rbenv global 3.1.2
    pyenv install 3.10.5 && pyenv global 3.10.5
    nodenv install 16.16.0 && nodenv global 16.16.0
    ```

### Update

1. Update
    ```bash
    cd ~/.dot_files && make update-all
    ```
    (Note) It is possible to update individually.
    ```bash
    make update-nvim
    ```
