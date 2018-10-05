#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return


################
# WSL Specific #
################

# Base16 Shell
BASE16_SHELL="$HOME/.config/base16-shell/"
[ -n "$PS1" ] && \
    [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
        eval "$("$BASE16_SHELL/profile_helper.sh")"

# Set SSH to use gpg-agent
unset SSH_AGENT_PID
if [ "${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ]; then
  export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
fi


###################
# Color Variables #
###################

RED='\e[0;31m'          # Red
B_RED='\e[1;31m'        # Bold Red

GREEN='\e[0;32m'        # Green
B_GREEN='\e[1;32m'      # Bold Green

YELLOW='\e[0;33m'       # Yellow
B_YELLOW='\e[1;33m'     # Bold Yellow

BLUE='\e[0;34m'         # Blue
B_BLUE='\e[1;34m'       # Bold Blue

L_GRAY='\e[0;37m'       # Light Gray
B_L_GRAY='\e[1;37m'     # Bold Light Gray

L_GREEN='\e[0;92m'      # Light Green
B_L_GREEN='\e[0;92m'    # Bold Light Green

L_BLUE='\e[0;94m'       # Light Blue
B_L_BLUE='\e[1;94m'     # Bold Light Blue

WHITE='\e[0;97m'        # White
B_WHITE='\e[1;97m'      # Bold White


#####################
# PS1 Configuration #
#####################

PS1_TIME="\[$L_GRAY\][\D{%H:%M:%S}]"
PS1_USER="\[$B_GREEN\]\u"

# Show hostname only if it is an SSH connection
if [ -n "$SSH_CLIENT" ]; then
    PS1_HOSTNAME="\[$L_GRAY\]@\[$B_GREEN\]\h"
else
    PS1_HOSTNAME=''
fi

PS1_WORKDIR=" \[$BLUE\]\w"
PS1_PROMPT="\n\[$B_L_BLUE\]❯ \[${L_GRAY}\]" #\342\235\257 = ❯

PS1="\n${PS1_TIME} ${PS1_USER}${PS1_HOSTNAME}${L_GRAY}: ${PS1_WORKDIR}${PS1_PROMPT}"

# Stop if failed to set PS1
[ -z "$PS1" ] && return


#################
# User Binaries #
#################

# ToDo: Move to system configuration file
# Add ~/bin to $PATH if it exists, is a directory and is not already in path
if [[ -d $HOME/bin && -z $(echo $PATH | grep -o $HOME/bin) ]]
then
    export PATH="${PATH}:$HOME/bin"
fi


###################
# Shell Behaviour #
###################

# Auto cd when directory path is entered as command
shopt -s autocd

# Append current session history when closing terminal
shopt -s histappend

# Don't add duplicates and commands that start with whitespace to history
HISTCONTROL=ignoredups:ignorespace


#######################
# GnuPG Configuration #
#######################

# Set GPG TTY
export GPG_TTY=$(tty)

# Refresh gpg-agent tty in case user switched into an X session
gpg-connect-agent updatestartuptty /bye >/dev/null


##################
# Colored Output #
##################

# less
export LESS=-R
export LESS_TERMCAP_mb=$'\e[1;31m'     # begin bold
export LESS_TERMCAP_md=$'\e[1;36m'     # begin blink
export LESS_TERMCAP_me=$'\e[0m'        # reset bold/blink
export LESS_TERMCAP_so=$'\e[01;44;33m' # begin reverse video
export LESS_TERMCAP_se=$'\e[0m'        # reset reverse video
export LESS_TERMCAP_us=$'\e[1;32m'     # begin underline
export LESS_TERMCAP_ue=$'\e[0m'        # reset underline

# ls
alias ls='ls --color=auto'

# diff
alias diff='diff --color=auto'

# grep
alias grep='grep --color=auto'

# man
man() {
    command man "$@"
}

# dmesg (when outputing to less)
alias dmesgc='dmesg --color=always'


###################
# Command Aliases #
###################

# User configuration manager repository
alias config="/usr/bin/git --git-dir=$HOME/.dotconfig --work-tree=$HOME"

# Make aliases available to sudo
alias sudo='sudo '

# Make opening files easier
alias open="xdg-open"

# trash-cli
alias tp='trash-put'

# Reminder to use trash-put instead of rm
alias rm='echo -e "${YELLOW}You should be using ${RED}tp (trash-put)${YELLOW}. '\
'Use ${RED}\\\rm${YELLOW} if you are really sure."; false'
