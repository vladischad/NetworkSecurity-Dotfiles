# bash/zsh settings common to both shells

function append_path {
    case ":$PATH:" in
        *":$1:"*) ;;
        *) PATH="$1:$PATH" ;;
    esac
}

#Add directories to PATH
append_path "$HOME/bin"
append_path "$HOME/.local/bin"

#Improve history behavior for interactive Bash sessions.
if [ -n "$BASH_VERSION" ]; then
    export HISTSIZE=10000
    export HISTFILESIZE=20000
    export HISTCONTROL=ignoredups:erasedups
    shopt -s histappend
fi

#Set the prompt for both ZSH and BASH
if [ -n "$ZSH_VERSION" ]; then
    precmd () {
        local exit_code=$?
        local status_prefix=""
        if [ "$exit_code" -ne 0 ]; then
            status_prefix="(x:${exit_code}) "
        fi
        __git_ps1 "%n@%m ${status_prefix}" ":%~ [%D{%H:%M:%S}]$ " "|%s"
    }
elif [ -n "$BASH_VERSION" ]; then
    __prompt_command () {
        local exit_code=$?
        local status_prefix=""
        if [ "$exit_code" -ne 0 ]; then
            status_prefix="(x:${exit_code}) "
        fi
        __git_ps1 "\u@\h ${status_prefix}\t \w" "\\\$ "
    }
    PROMPT_COMMAND=__prompt_command
fi

#Turn on git-prompt settings
GIT_PS1_SHOWCOLORHINTS=true
GIT_PS1_SHOWUPSTREAM=auto
GIT_PS1_DESCRIBE_STYLE=branch
GIT_PS1_SHOWDIRTYSTATE=true
GIT_PS1_SHOWSTASHSTATE=true
GIT_PS1_SHOWUNTRACKEDFILES=true

#Add in alias
alias ..='cd ..'
alias ...='cd ../..'
alias ll='ls -lah'
alias la='ls -l -a'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias gs='git status -sb'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
