#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return


#RED="\\[\e[0;31m\\]"       # Red
#B_RED="\\[\e[1;31m\\]"     # Bold Red

#GREEN="\\[\e[0;32m\\]"     # Green
B_GREEN="\\[\e[1;32m\\]"    # Bold Green

#YELLOW="\\[\e[0;33m\\]"    # Yellow
#B_YELLOW="\\[\e[1;33m\\]"  # Bold Yellow

#BLUE="\\[\e[0;34m\\]"      # Blue
B_BLUE="\\[\e[1;34m\\]"     # Bold Blue

L_GRAY="\\[\e[0;37m\\]"     # Light Gray
#B_L_GRAY="\\[\e[1;37m\\]"  # Bold Light Gray

#L_GREEN="\\[\e[0;92m\\]"   # Light Green
#B_L_GREEN="\\[\e[0;92m\\]" # Bold Light Green

#L_BLUE="\\[\e[0;94m\\]"    # Light Blue
B_L_BLUE="\\[\e[1;94m\\]"   # Bold Light Blue

#WHITE="\\[\e[0;97m\\]"     # White
#B_WHITE="\\[\e[1;97m\\]"   # Bold White

#PS1='[\u@\h \W]\$ '
if [ -n "$SSH_CLIENT" ]; then
    SHOW_HOSTNAME="${L_GRAY}@${B_GREEN}\h"
else
    SHOW_HOSTNAME=''
fi
#\342\235\257 = ❯
PS1="${L_GRAY}[\D{%H:%M:%S}] ${B_GREEN}\u${SHOW_HOSTNAME}${L_GRAY}: ${B_BLUE}\w
${B_L_BLUE}❯ ${L_GRAY}"

# Stop if failed to set PS1
[ -z "$PS1" ] && return

# Auto cd when dir path entered as command
shopt -s autocd

# Append current session history when closing terminal
shopt -s histappend


# Set GPG TTY
export GPG_TTY=$(tty)

# Refresh gpg-agent tty in case user switcher into an X session
gpg-connect-agent updatestartuptty /bye >/dev/null


# Colorful less
export LESS=-R
export LESS_TERMCAP_mb=$'\E[1;31m'     # begin bold
export LESS_TERMCAP_md=$'\E[1;36m'     # begin blink
export LESS_TERMCAP_me=$'\E[0m'        # reset bold/blink
export LESS_TERMCAP_so=$'\E[01;44;33m' # begin reverse video
export LESS_TERMCAP_se=$'\E[0m'        # reset reverse video
export LESS_TERMCAP_us=$'\E[1;32m'     # begin underline
export LESS_TERMCAP_ue=$'\E[0m'        # reset underline

# Colorful ls
alias ls='ls --color=auto'

# Colorful diff
alias diff='diff --color=auto'

# Colorful grep
alias grep='grep --color=auto'

# Colorful man
man() {
	command man "$@"
}

# Colorful dmesg when outputing to less
alias dmesgc='dmesg --color=always'

# Alias trash-put from trash-cli to tp
alias tp='trash-put'

# Alias rm to reminder to use trash-put
alias rm='echo -e "\e[0;33mYou are probably looking for tp (trash-put), use \\\rm if you really want it."; false'

# Don't add duplicates and commands that start with whitespace to history
HISTCONTROL=ignoredups:ignorespace


# if ~/bin exists and is a directory & if ~/bin is not already in your $PATH
# then export ~/bin to your $PATH.
if [[ -d $HOME/bin && -z $(echo $PATH | grep -o $HOME/bin) ]]
then
    export PATH="${PATH}:$HOME/bin"
fi


# Alias for dotconfig managing repository
alias dotconfig="/usr/bin/git --git-dir=$HOME/.dotconfig --work-tree=$HOME"
