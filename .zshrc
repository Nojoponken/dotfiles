# ~/.zshrc
chmod +x /home/$USER/.scripts/*
export PATH=$PATH:/home/$USER/.scripts
export CXX=clang++
export C=clang

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

zstyle :compinstall filename '/home/noali443/.zshrc'
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
alias diff="diff --color=always"
alias cd="z"
alias c="clear&&"
alias cb='xargs echo -n | wl-copy'
alias nf="neofetch"
alias ff="fastfetch"

alias play="./game --lobby-ip elekrisk.com"
alias moba="cd ~/Spel/moba"
alias hx="helix"

alias sp="~/TDDI41/TDDI41/start_project.sh"
alias ss="~/TDDI41/TDDI41/start_single.sh"

alias locip="ifconfig wlan0|awk '/inet/{print \$2}'|cowsay"
alias wmoni="swaymsg -t get_outputs | jq  -r '.[] | select(.dpms and .active).name'"
alias ib="cowsay Is bloat"
alias om="clear &&
            cowsay Two && 
            sleep 0.1 && clear &&
            cowsay Two words... && 
            sleep 1.5 && clear &&
            cowsay Two words Org &&
            sleep 0.2 && clear &&
            cowsay Two words Org mode"

alias aliaunch-deb="qemu-system-x86_64 -m 2048 -hda debian-vm1.qcow2 -vga std -netdev user,id=net0,hostfwd=tcp::2222-:22 -device e1000,netdev=net0 -display sdl"

function launch-ran()
{
    qemu-system-x86_64 -m 2048 -hda ~/VMs/ranch-vm$1.qcow2 -vga std -netdev user,id=net0,hostfwd=tcp::222$1-:22 -device e1000,netdev=net0 -display sdl
}

function launch-deb()
{
    qemu-system-x86_64 -m 2048 -hda ~/VMs/deb-vm$1.qcow2 -vga std -netdev user,id=net0,hostfwd=tcp::222$1-:22 -device e1000,netdev=net0 -display sdl
}

alias up="yay -Syu"
alias get="yay -S"
alias rem="yay -R"

# C/C++ aliases
alias g++17="g++ -std=c++17 -Wall -Wextra -pedantic -Weffc++ -Wsuggest-attribute=const -fconcepts"

alias cbld="cmake . -B build"
alias bld="cmake --build build"
alias rn="./build/App"

# Wayfire alias
alias wayfire="wayfire -c ~/.config/wayfire/wayfire.ini"

# Perl
PATH="/home/noali443/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/home/noali443/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/home/noali443/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/home/noali443/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/noali443/perl5"; export PERL_MM_OPT;

eval "$(fzf --zsh)"
eval "$(zoxide init zsh)"
