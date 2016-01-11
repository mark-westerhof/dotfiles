# Terminal
[[ -f $HOME/.base16_shell.sh ]] && . $HOME/.base16_shell.sh
if [[ -n "$TMUX" ]]; then
    if [[ $(tmux showenv TERM 2>/dev/null) =~ .*256color ]]; then
        export TERM='screen-256color'
    else
        export TERM='screen'
    fi
fi

[ -d "$HOME/bin" ] && PATH="$HOME/bin:$PATH"
[ -d "$HOME/.local/bin" ] && PATH="$HOME/.local/bin:$PATH"

export EDITOR=vim
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

# Development tmux helper
function devsession() {
    directory=${1%/}
    (cd $directory && tmux new -s $directory)
}

# Aliases
alias setup_ssh_clipboard='. ~/.ssh_clipboard'
alias fortigate='fgtdev conf get fortigate | awk -F ": " "{print \$2}"'
alias fortigate_port='fgtdev conf get ssh_port | awk -F ": " "{print \$2}"'
alias sshfgt='ssh -p $(fortigate_port) admin@$(fortigate)'
alias createtags='git ls-files | grep -v -E "^linux-" | ctags -R -L -'
alias gpush='git push origin HEAD:refs/for/$(git rev-parse --abbrev-ref HEAD)'
