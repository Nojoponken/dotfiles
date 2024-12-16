# ~/.zshrc

# History
HISTFILE=~/.histfile
HISTSIZE=5000
SAVEHIST=5000
HISTDUP=erase

# Keybinds
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

# Options
unsetopt beep
setopt prompt_subst
setopt appendhistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

zstyle :compinstall filename '/home/noah/.zshrc'
autoload -Uz compinit
compinit

# Prompt
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git svn
zstyle ':vcs_info:git*' formats " %F{3}[ %b]"
precmd() {
    vcs_info
}

PROMPT='%K{default}%F{8}%f%n%F{1}@%m %F{12}%~${vcs_info_msg_0_}%K{default}%F{11} %(!.#.$) %f'

# Plugins
source "${HOME}/.zgen/zgen.zsh"

zgen load zsh-users/zsh-syntax-highlighting 
zgen load zsh-users/zsh-completions 
zgen load zsh-users/zsh-autosuggestions 

# Aliases
alias ll="ls -alF --color=auto"
alias ls="ls -aF --color=auto"
alias cd="z"
alias up="sudo pacman -Syu"
alias get="sudo pacman -S"
alias rem="sudo pacman -R"
alias g++17="g++ -std=c++17 -Wall -Wextra -pedantic -Weffc++ -Wsuggest-attribute=const -fconcepts"

eval "$(fzf --zsh)"
eval "$(zoxide init zsh)"