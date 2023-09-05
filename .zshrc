######################################################
#  .zshrc -- zsh resource file                       #
#                                                    #
# Is sourced if interactive.                         #
######################################################

# NOTE: Path-stuff is moved to .zshenv !
export EDITOR="emacsclient -nw -a nano"
export GDFONTPATH=${HOME}:${GDFONTPATH}

set noclobber

# Fix number of open files in OSX (e.g. for torrents) - should be e.g. 2048
ulimit -n 2048

# Git-token for Homebrew
# source ~/.homebrew_token

# Display Danish letters correctly
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

#------------------------------
# Research-stuff
#------------------------------
# Note: Path-things moved to .zshenv
# Adipls
export aprgdir=${HOME}/adipack

# Garstec (STARHOME set in .zshenv)
# source ${STARHOME}/initstar.sh

# For thesis: Get bibliography from BibDesk
# alias upbib='cp /Users/moss/Library/Mobile\ Documents/com\~apple\~CloudDocs/work/references/library.bib .'


#------------------------------
# SSH tunneling
#------------------------------
alias opentunnel='ssh -f -N -D 9090 archive'
alias tunnelchrome='"/Applications/Google Chrome.app/Contents/MacOS/Google Chrome" --user-data-dir="$HOME/proxy-profile" --proxy-server="socks5://localhost:9090"'
alias findtunnel='ps aux | grep 9090'


#------------------------------
# Python and virtualenv
#------------------------------
# Fix of problems with open files (Jedi/Spacemacs issue)
# (github.com/davidhalter/jedi/issues/1229)
alias fixopenfiles='sudo launchctl limit maxfiles 2048 524288'

# Quick aliases for the pyenv virtualenv commands
alias pya='pyenv activate'
alias pyd='source deactivate'

# Emulate virtualenvwrapper commands (ish)
# function workon {
#     source ~/venvs/"$@"/bin/activate
# }

# function mkvenv {
#     CWD=`pwd`
#     cd ~/venvs/ && python3 -m venv "$@"
#     cd $CWD
#     unset CWD
# }

# function mkvenvsys {
#     CWD=`pwd`
#     cd ~/venvs/ && python3 -m venv "$@"
#     cd "$@" && sed -i.bak s/false/true/g pyvenv.cfg
#     cd $CWD
#     unset CWD
#     echo '~/venvs/NAME/pyenv.cfg have been modified !'
# }

# function mkvenvipy {
#     CWD=`pwd`
#     cd ~/venvs/ && python3 -m venv "$@"
#     workon "$@"
#     pip install ipython
#     echo 'iPython has been installed!'
#     deactivate
#     cd "$@" && sed -i.bak s/false/true/g pyvenv.cfg
#     cd $CWD
#     unset CWD
#     echo '~/venvs/NAME/pyenv.cfg have been modified !'
# }

# function rmvenv {
#     rm -r ~/venvs/"$@"
# }


#------------------------------
# History stuff
#------------------------------
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
setopt HIST_IGNORE_SPACE


#------------------------------
# Completion
#------------------------------
if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh-completions:$FPATH

  autoload -Uz compinit
  compinit
fi

autoload -U compinit
compinit

zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]} r:|[._-]=** r:|=**' 'l:|=* r:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle :compinstall filename '/home/moss/.zshrc'

setopt completealiases

# Automatically find newly installed programs
_force_rehash() {
    (( CURRENT == 1 )) && rehash
    return 1
}

#------------------------------
# Keybingings
#------------------------------
bindkey "^[[A" history-beginning-search-backward
bindkey "^[[B" history-beginning-search-forward

#------------------------------
# Aliases
#------------------------------
# List
alias ls='ls -G -h'
alias l='ls -G -h'
alias ll='ls -G -lF -h'
alias la='ls -G -alF -h'
alias lt='ls -G -ltF -h'

# Random
alias clear='echo "Use C-l to clear"'
alias exit='echo "Use C-d to exit"'

# Editor
alias ec='emacsclient -t'
alias en='emacsclient -n'
alias ew='emacs -nw'
alias eq='emacs -nw -q'

# Folders
export phd='/Users/au324463/nextCloud/phd/'
export postdoc='/Users/au324463/nextCloud/postdoc/'
export work='/Users/au324463/nextCloud/postdoc/projects/'
export icloud='/Users/au324463/Library/Mobile Documents/com~apple~CloudDocs'

# Git
alias gs='git status'
alias gf='git fetch'
alias gfs='gf; gs'

# ds9 and iraf
#alias ds9='ds9 -language en'
#alias xgterm='xgterm -ls &'

# R
# alias rr='/usr/local/bin/r'

# System maintaince
cle () {
    if [ $(uname) = "Darwin" ]; then
        print "Cleaning homebrew software"
        brew cleanup
    elif [[ $(uname) = "Linux" && $(lsb_release -si) = "Ubuntu" ]]; then
        print "Cleaning software from apt-get"
        sudo apt-get autoremove
        sudo apt-get autoclean
    elif [[ $(uname) = "Linux" && $(lsb_release -si) = "Arch" ]]; then
        print "Cleaning software from pacman"
        sudo pacman -Rs $(pacman -Qqtd); sudo pacman -Sc
    else
        print "Cleaning failed: OS is not OSX, Ubuntu or Arch"
    fi
}

up () {
    if [ $(uname) = "Darwin" ]; then
        print "Updating OSX and App Store software"
        sudo softwareupdate -ia
        print "Updating homebrew software"
        brew update
        brew upgrade
    elif [[ $(uname) = "Linux" && $(lsb_release -si) = "Ubuntu" ]]; then
        print "Updating software from apt-get"
        sudo apt-get update
        sudo apt-get upgrade
    elif [[ $(uname) = "Linux" && $(lsb_release -si) = "Arch" ]]; then
        print "Updating software from pacman"
        sudo pacman -Syu
    else
        print "Updating failed: OS is not OSX, Ubuntu or Arch"
    fi

    if (( $+commands[tlmgr] )); then
        print "Updating TeX Live"
        sudo tlmgr update --self
        sudo tlmgr update --all
    fi
}

# Python maintainance
pip2up () {
    pipupinner pip2
}

pip3up () {
    pipupinner pip3
}

function pipupinner() {
    $1 --version
    $1 install --upgrade pip
    $1 freeze --local | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 $1 install -U
}

#------------------------------
# Power management
#------------------------------
alias lock='alock -auth pam -bg blank'
alias suspend='lock & sudo pm-suspend'

#------------------------------
# Prompt and colors
#------------------------------
# load some modules
autoload -U colors zsh/terminfo # Used in the colour alias below
colors
setopt prompt_subst

# make some aliases for the colours: (coud use normal escap.seq's too)
for color in RED GREEN YELLOW BLUE MAGENTA CYAN WHITE GREY; do
    eval PR_$color='%{$fg[${(L)color}]%}'
done
PR_NO_COLOR="%{$terminfo[sgr0]%}"

# Check the UID
if [[ $UID -ge 500 ]]; then # normal user
    eval PR_USER='${PR_CYAN}%n${PR_NO_COLOR}'
    eval PR_USER_OP='${PR_CYAN}%#${PR_NO_COLOR}'
elif [[ $UID -eq 0 ]]; then # root
    eval PR_USER='${PR_RED}%n${PR_NO_COLOR}'
    eval PR_USER_OP='${PR_RED}%#${PR_NO_COLOR}'
fi

# Check if we are on SSH or not
if [[ -n "$SSH_CLIENT" || -n "$SSH2_CLIENT" ]]; then
    eval PR_HOST='${PR_YELLOW}%M${PR_NO_COLOR}' #SSH
else
    eval PR_HOST='${PR_GREEN}%m${PR_NO_COLOR}' # no SSH
fi

eval PR_RET='%(?..${PR_RED}%?${PR_NO_COLOR} )'

# Set the prompt (short path from unix.stackexchange.com/questions/273529)
PS1=$'${PR_RET}${PR_BLUE}[${PR_USER}${PR_BLUE}@${PR_HOST}${PR_BLUE}][${PR_BLUE}%(4~|%-1~/…/%2~|%3~)${PR_BLUE}] ${PR_USER_OP}%{$reset_color%} '
PS2=$'%_>'
RPROMPT='${PR_BLUE}$(date +%T)%{$reset_color%}'

#------------------------------
# Window title
#------------------------------
case $TERM in
    termite|*xterm*|rxvt|rxvt-unicode|rxvt-256color|rxvt-unicode-256color|(dt|k|E)term)
    precmd () { print -Pn "\e]0;[%n@%M][%~]%#\a" }
    preexec () { print -Pn "\e]0;[%n@%M][%~]%# ($1)\a" }
    ;;
    screen)
        precmd () {
            print -Pn "\e]83;title \"$1\"\a"
            print -Pn "\e]0;$TERM - (%L) [%n@%M]%# [%~]\a"
        }
        preexec () {
            print -Pn "\e]83;title \"$1\"\a"
            print -Pn "\e]0;$TERM - (%L) [%n@%M]%# [%~] ($1)\a"
        }
        ;;
esac


#------------------------------
# Highlighting
#------------------------------
# New location of Homebrew -- automatically detected
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

#------------------------------
# Pyenv load (also in .zshenv)
#------------------------------
if command -v pyenv 1>/dev/null 2>&1; then
    eval "$(pyenv init --path)"
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"
fi

#------------------------------
# iTerm shell integration
#------------------------------
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
