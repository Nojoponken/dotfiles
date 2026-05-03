alias bat=batcat

# History
HISTFILE=~/.histfile
HISTSIZE=5000
SAVEHIST=5000
HISTDUP=erase

# Keybinds
# bindkey -e
# bindkey '^p' history-search-backward
# bindkey '^n' history-search-forward

# Options
unsetopt beep
setopt prompt_subst
setopt appendhistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
# zstyle ':completion:*' completer _extensions _complete _approximate
zstyle ':completion:*' menu select
zstyle ':completion:*' squeeze-slashes true

zstyle :compinstall filename '/home/noali443/.zshrc'
autoload -Uz compinit
compinit

# Prompt
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git svn
zstyle ':vcs_info:git*' formats " %F{3}[ %b]%K{default}"
precmd() {
    vcs_info
}

PROMPT='%K{default}%f%n%F{1}@%m %F{12}%~${vcs_info_msg_0_} %F{11}%(!.#.$) %f'

# Plugins
source "${HOME}/.zgen/zgen.zsh"

zgen load zsh-users/zsh-syntax-highlighting 
zgen load zsh-users/zsh-completions 
zgen load zsh-users/zsh-autosuggestions 

# Normal Aliases
alias ll="ls -alF --color=auto"
alias ls="ls -aF --color=auto"
alias diff="diff --color=always"
alias vimr="vim ~/.vimrc"
alias vimz="vim ~/.zshrc"

alias truth="cowsay -f kosh You\'ve been fooled if you think Vim is even remotely comparable to Emacs."

alias om="clear &&
            cowsay Two && 
            sleep 0.1 && clear &&
            cowsay Two words... && 
            sleep 1.5 && clear &&
            cowsay Two words Org &&
            sleep 0.2 && clear &&
            cowsay Two words Org mode"


function hl()
{
    sed -E -e "/$1/s/^/[31m/;s/$/[37m/" -e "/$2/s/^/[34m/"
}

# C/C++ aliases
alias g++17="g++ -std=c++17"
alias w++17="g++ -std=c++17 -pedantic -Wall -Wextra"
alias e++17="g++ -std=c++17 -pedantic -Wall -Wextra -Werror"
alias g++20="g++ -std=c++20"
alias w++20="g++ -std=c++20 -pedantic -Wall -Wextra"
alias e++20="g++ -std=c++20 -pedantic -Wall -Wextra -Werror"

alias cbld="cmake . -B build"
alias bld="cmake --build build"

eval "$(fzf --zsh)"
eval "$(zoxide init zsh)"

export PATH="$PATH:/home/noah/.local/bin"
