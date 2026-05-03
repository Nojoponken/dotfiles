alias bat=batcat

function show_colour() {
    perl -e 'foreach $a(@ARGV){print "\e[48:2::".join(":",unpack("C*",pack("H*",$a)))."m \e[49m "};print "\n"' "$@"
}

function music() {
    mpv --no-video "ytdl://ytsearch:$*"
}

alias nojotheme="show_colour '111111' 'bb4466' '66bb44' 'bb6644' '4466bb' '6644bb' '44bb66' '333333' && show_colour '888888' 'ff88bb' 'bbff88' 'ffbb88' '88bbff' 'bb88ff' '88ffbb' 'cccccc'"
alias dcu="sudo docker-compose up -d"
alias dcd="sudo docker-compose down"
alias dps="sudo docker ps"

# ~/.zshrc
chmod +x /home/$USER/.scripts/*
export PATH=$PATH:/home/$USER/.scripts
# export CXX=clang++
# export CC=clang
# export CMAKE_MAKE_PROGRAM=make
# export CMAKE_C_COMPILER=gcc
# export CMAKE_CXX_COMPILER=g++
# export CMAKE_EXPORT_COMPILE_COMMANDS=1

alias prox="ssh noali443@ssh.edu.liu.se -L 8006:localhost:8006 -L 8007:localhost:8007 -L 8008:localhost:8008 -L 8009:localhost:8009 -L 8010:localhost:8010 -L 8011:localhost:8011"

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

# zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
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
 
# Gif Aliases
alias slam="viu --height 10 ~/Images/kiryu-desk-slam-kiryu.gif"
alias hack="viu --height 10 ~/Images/hacker-pepe.gif"
alias cope="viu --height 10 ~/Images/pepe-copium.gif"
alias nooo="viu --height 10 ~/Images/noooo.gif"
alias trol="viu --height 10 ~/Images/troll.gif"
alias baus="viu --height 10 ~/Images/thebaussffs-baus.gif"
alias dial="viu --height 10 ~/Images/dialup.gif"

# Normal Aliases
alias up="yay -Syu"
alias get="yay -S"
alias rem="yay -R"

alias kbd="cat ~/se-coder-readme;read"
alias ll="ls -alF --color=auto"
alias ls="ls -aF --color=auto"
alias diff="diff --color=always"
alias c="clear&&"
alias cb='xargs echo -n | wl-copy'
alias nf="neofetch"
alias ff="fastfetch"
alias vimr="vim ~/.vimrc"
alias vimz="vim ~/.zshrc"

alias pts="phoronix-test-suite"

alias play="./game --lobby-ip elekrisk.com"
alias moba="cd ~/Spel/moba"

alias sp="~/TDDI41/TDDI41/start_project.sh"
alias ss="~/TDDI41/TDDI41/start_single.sh"

alias locip="ip a |awk '/inet.*enp1s0/{print \$2}'|cowsay"
alias ncip="c locip && nc -l 8080"
alias wmoni="swaymsg -t get_outputs | -r '.[] | select(.dpms and .active).name'"
alias ib="cowsay Is bloat"
alias kanin="cowsay -f bunny '10 miljoner?'"
alias truth="cowsay -f kosh You\'ve been fooled if you think Vim is even remotely comparable to Emacs."

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

function hl()
{
    sed -E -e "/$1/s/^/[31m/;s/$/[37m/" -e "/$2/s/^/[34m/"
}

function ytvlc()
{
    yt-dlp -f bestvideo -g "ytsearch:$1" | read VIDEO_URL &
    yt-dlp -f bestaudio -g "ytsearch:$1" | read AUDIO_URL &
    wait
    cvlc "$VIDEO_URL" --input-slave="$AUDIO_URL"
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

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# bun completions
[ -s "/home/noah/.bun/_bun" ] && source "/home/noah/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# Created by `pipx` on 2026-02-02 12:16:29
export PATH="$PATH:/home/noah/.local/bin"
