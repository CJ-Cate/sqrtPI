# If not running interactively, don't do anything
[[ $- != *i* ]] && return

echo ""
fastfetch

if [[ -f /tmp/hack-ip ]]; then
    export ip=$(cat /tmp/hack-ip 2>/dev/null)
    echo "Ip has been set! Ip is: $ip"
fi

##
## Behaviour Configuration
##

export TERM="tmux-256color"
#export BROWSER="librewolf"

setopt extended_glob dot_glob #null_glob # mimic bash behaviour, allegedly.
setopt auto_param_slash # add a '/' when autocompleting directories instead of trailing space
setopt interactive_comments # allow comments in shell.

HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
setopt hist_ignore_space # dont save when the first character in a command is a space
setopt share_history append_history inc_append_history # share history between sessions, append history, append immedietly
#setopt HIST_IGNORE_DUPS # dont save duplicate lines. i dont mind though, duplicates tell a story.

# Autocomplete
autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' # case insensitivity, by LLM
# zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*' # alternate matcher-list thingy

bindkey "^[[H" beginning-of-line # home
bindkey "^[[1~" beginning-of-line # home

bindkey "^[[F" end-of-line # end
bindkey "^[[4~" end-of-line # end

bindkey "^[[1;5C" forward-word # scroll right one word
bindkey "^[[1;5D" backward-word # scroll left one word

bindkey "^[[3~" delete-char # delete key functionality

bindkey "^H" backward-kill-word # ctrl+backspace
bindkey "^[[3;5~" kill-word # ctrl+delete
#bindkey "~5" kill-word # ctrl+delete # causes delay

# Replace the Ctrl+C behaviour, so instead of making a new line it clears the current line
#TRAPINT() { return $(( 128 + $1 )) }

# Enable autocomplete: https://github.com/zsh-users/zsh-autosuggestions?tab=readme-ov-file
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

##
## QoL Configurations
##

# Replace ls with exa
alias ls='exa -al --color=always --group-directories-first --icons'     # preferred listing
alias lt='exa -aT --color=always --group-directories-first --icons'     # tree listing
alias l.='exa -ald --color=always --group-directories-first --icons .*' # show only dotfiles
# Replace cat with more style
#alias cat='bat --style header --style snip --style changes --style header'

# Common use
alias cls="clear; ls"
alias wget='wget -c '
alias rmpkg="sudo pacman -Rns"
alias kill-batman='sudo pacman -Rns $(pacman -Qtdq)' # Cleanup orphaned packages 
#alias grubup="sudo update-grub"
#alias fixpacman="sudo rm /var/lib/pacman/db.lck"
alias big="expac -H M '%m\t%n' | sort -h | nl"     # Sort installed packages according to size in MB (expac must be installed)
alias jctl="journalctl -p 3 -xb" # Get the error messages from journalctl
alias rip="expac --timefmt='%Y-%m-%d %T' '%l\t%n %v' | sort | tail -200 | nl" # recently installed packages
alias mirrord="sudo reflector --latest 50 --number 20 --sort delay --save /etc/pacman.d/mirrorlist" # Update mirrors based on delay
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'
alias code='codium'
#alias vim='nvim'

# Add colours to things by default
alias grep='ugrep --color=auto'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias fgrep='ugrep -F --color=auto'
alias egrep='ugrep -E --color=auto'
alias ip='ip -color'

# Personal modifications
alias setip="wl-paste > /tmp/hack-ip; export ip=$(wl-paste); echo Ip is now: $ip"
alias doip="export ip=$(cat /tmp/hack-ip); echo Ip is now: $ip"
alias ff="fastfetch"
alias zz="clear; source ~/.zshrc"
alias xx="source ~/.sq-zshrc; tmux source-file ~/.sq-tmux.conf 2>/dev/null"
alias hrr="hyprctl --instance 0 reload"
alias theme="/home/cj/sqrtPI/Scripts/theme-switcher.sh"
alias hostinger="ssh root@31.97.214.217"
alias droplet1="ssh root@138.197.234.97"
export droplet1="root@138.197.234.97"
alias mysql="/usr/bin/mariadb"
alias plex="ssh -L 8080:127.0.0.1:8080 cj@10.0.0.73"

source ~/.sq-zshrc

# ZSH syntax highlighting, must be last line as per: https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/INSTALL.md
#source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
