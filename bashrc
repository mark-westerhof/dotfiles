# Path
[ -d "$HOME/bin" ] && PATH="$HOME/bin:$PATH"
[ -d "$HOME/.local/bin" ] && PATH="$HOME/.local/bin:$PATH"

# Theme
if [ -f $HOME/.shell_theme.sh ]; then
    . $HOME/.shell_theme.sh
fi

# "Ctrl h" fix https://github.com/neovim/neovim/issues/2048
if [[ -f "$HOME/$TERM.ti" ]]; then
    tic $HOME/$TERM.ti
fi

# Editor
editor='vim'
if command -v nvim >/dev/null 2>&1; then
    editor='nvim'
    alias vim='nvim'
fi
export EDITOR=$editor

# FOS env
export USESUDO=$(which sudo)

# fzf
[ -f "$HOME/.fzf.bash" ] && source $HOME/.fzf.bash
export FZF_DEFAULT_COMMAND='ag -l -g ""'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# Node/NPM
if [ -f "$HOME/.nvm/nvm.sh" ]; then
    export NVM_DIR="$HOME/.nvm"
    source $NVM_DIR/nvm.sh
    export NODE_PATH=$(npm root -g)
fi

# SSH/clipboard aliases
alias ssh_clip_support='ssh -R 6788:localhost:22'
alias remoteclip='ssh -p 6788 localhost pbcopy'

# FOS aliases
alias fortigate='fgtdev conf get fortigate | awk -F ": " "{print \$2}"'
alias fortigate_port='fgtdev conf get ssh_port | awk -F ": " "{print \$2}"'
alias sshfgt='ssh -p $(fortigate_port) admin@$(fortigate)'

# Development aliases
alias createtags='git ls-files | grep -v -E "^linux-" | ctags -R -L -'
alias gpush='git push origin HEAD:refs/for/$(git rev-parse --abbrev-ref HEAD)'

# Print 256 color map for reference
function printcolors() {
    n=${1-16}
    for i in {0..255}; do
        printf "\e[48;05;%sm  %-3s  " $i $i
        if [[ $((($i + 1) % $n)) == 0 ]]; then
            printf "\n"
        fi
    done
    echo -e "\e[m"
}

# Development tmux helper
function devsession() {
    directory=${1%/}
    (cd $directory && tmux new -s $directory)
}

# Source code indexing
function indexsource() {
    echo "Creating ctags..."
    createtags
    echo "Creating cscope db..."
    rm -f cscope.*
    cscope -R -b -q -k
}
