# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Editor
export EDITOR="vim"
# I would use vim mode, but I'm already used to emacs mode and it doesn't have ctrl+r
bindkey -e

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
# NOTE: zsh-syntax-highlighting must be last so it can properly hook zle.
plugins=(git gh python zsh-autosuggestions colored-man-pages docker docker-compose fast-syntax-highlighting)

[[ ! -f $ZSH/oh-my-zsh.sh ]] || source $ZSH/oh-my-zsh.sh

# User configuration

# Make vim the default editor.
export EDITOR='vim';

# Enable persistent REPL history for `node`.
export NODE_REPL_HISTORY=~/.node_history;
# Allow 32³ entries; the default is 1000.
export NODE_REPL_HISTORY_SIZE='32768';
# Use sloppy mode by default, matching web browsers.
export NODE_REPL_MODE='sloppy';

# Make Python use UTF-8 encoding for output to stdin, stdout, and stderr.
export PYTHONIOENCODING='UTF-8';

# Increase Bash history size. Allow 32³ entries; the default is 500.
export HISTSIZE='32768';
export HISTFILESIZE="${HISTSIZE}";
# Omit duplicates and commands that begin with a space from history.
export HISTCONTROL='ignoreboth';

# Prefer US English and use UTF-8.
export LANG='en_US.UTF-8';
export LC_ALL='en_US.UTF-8';

# Highlight section titles in manual pages.
export LESS_TERMCAP_md="${yellow}";

if [ ! $(command -v batcat) ]; then
  # We don't have batcat, use less for manpages.
  # Don’t clear the screen after quitting a manual page.
  export MANPAGER='less -X';
else
  export MANPAGER="sh -c 'col -bx | batcat -l man -p'"
fi

# Fix colors when using tmux.
export TERM=xterm-256color

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

########
# PATH #
########

# Cargo
if [ -d ~/.cargo/bin ]; then
  export PATH="$HOME/.cargo/bin:$PATH"
fi

# Pyenv
if [ -d ~/.pyenv/bin ]; then
  export PATH="$HOME/.pyenv/bin:$PATH"
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
fi

# Nvm (Node version manager)
if [ -d ~/.nvm ]; then
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
fi

# .local/bin (python tools and stuff)
[[ -d ~/.local/bin ]] && export PATH="$HOME/.local/bin:$PATH"

# Ruby tools
[[ -d ~/.gem/ruby/2.7.0/bin ]] && export PATH="$HOME/.gem/ruby/2.7.0/bin:$PATH"

# Go tools
[[ -d ~/go/bin ]] && export PATH="$HOME/go/bin:$PATH"

# Scripts
[[ -d ~/scripts ]] && export PATH="$HOME/scripts:$PATH"

# processing
[[ -d /opt/processing-3.5.4/ ]] && export PATH="/opt/processing-3.5.4:$PATH"

# stderred
STDERRED_SO="$HOME/.stderred/build/libstderred.so"
[[ -f $STDERRED_SO ]] && export LD_PRELOAD="$STDERRED_SO${LD_PRELOAD:+:$LD_PRELOAD}"

# Brew
[[ -d /home/linuxbrew ]] && eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)

############
# ALIASES #
###########

# Misc
sudo () {
   /usr/bin/sudo "PATH=$PATH" "$@"
}
docker () {
  sudo docker "$@"
}
alias psql="sudo -u postgres psql"

alias lsa="ls -a"
alias bat="batcat"
# For when my headphones don't work, I run this command a few times until it says
#  "Terminating process". Once it says that, the headphones start working. Weird.
alias afr="sudo alsa force-reload"
# Found this in my .bashrc
alias notifycmd='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
# I find this cmd more convienent: 'notify "XXX finished"'
alias notify="notify-send --urgency=low"
# Use clipboard (WAY easier than using mouse)
alias copy="xclip -sel c"
alias paste="xclip -o -sel c"
# I put 64 bit .so files in my LD_PRELOAD (stderred), wine warns about them so don't
#  use any of them for wine
alias wine="LD_PRELOAD= wine"

# Git
alias ga="git commit -am" # Commit everything (a stands for all ig)
alias gc="git commit"
alias gs="git status"
alias gp="git push"

# When git status says I edited something, I can run gd <file> or just gd .
alias gd="git diff HEAD --"

# Functions

# Usage: ls -1 folder_with_long_filenames | nowrap
nowrap () {
  tput rmam
  <&0 cat
  tput smam
}

cl () {
  # Show the amount of commits in repo
  # e.g. cl # all branches
  # cl master # just master
  git rev-list --count ${1:-'--all'}
}

mkcd () {
  mkdir -p "$1"
  cd "$1"
}

trash () {
  python -c "from send2trash import send2trash as s; s('$1')"
}

speedswap () {
  # Swaps the functions of caps lock and escape. Very useful, especially for vim. Who
  #  uses caps lock anyway?
  # I run this on launch as well

  # Contents of ~/.speedswapper (no spaces at front)
  # ! Swap caps lock and escape
  # remove Lock = Caps_Lock
  # keysym Escape = Caps_Lock
  # keysym Caps_Lock = Escape
  # add Lock = Caps_Lock
  xmodmap ~/.speedswapper
}

vmmap () {
  # When using vmmap, I use speedswap *inside* the vm so speedswap can't be running on
  #  my host machine or the vm can't use it
  # This script removes the binding for caps lock so the
  #  vm can use it
  setxkbmap -option caps:none
}

resetkeys () {
  # Resets keymap back to default. Resets to old state before speedswap/vmmap
  setxkbmap -option
}

unvmmap () {
  # After I'm done in the vm, reload speedswap (it was loaded on login but clobbered by
  #  vmmap)
  resetkeys
  speedswap
}

# apologies for the formatting here. It would break the heredocs so I didn't indent 
scrollspeed () {
  #!/bin/bash
# Version 0.1 Tuesday, 07 May 2013
# Comments and complaints http://www.nicknorton.net
# GUI for mouse wheel speed using imwheel in Gnome
# imwheel needs to be installed for this script to work
# sudo apt-get install imwheel
# Pretty much hard wired to only use a mouse with
# left, right and wheel in the middle.
# If you have a mouse with complications or special needs,
# use the command xev to find what your wheel does.
#
### see if imwheel config exists, if not create it ###
if [ ! -f ~/.imwheelrc ]
then

cat >~/.imwheelrc<<EOF
".*"
None,      Up,   Button4, 1
None,      Down, Button5, 1
Control_L, Up,   Control_L|Button4
Control_L, Down, Control_L|Button5
Shift_L,   Up,   Shift_L|Button4
Shift_L,   Down, Shift_L|Button5
EOF

fi
##########################################################

CURRENT_VALUE=$(awk -F 'Button4,' '{print $2}' ~/.imwheelrc)

NEW_VALUE=$(zenity --scale --window-icon=info --ok-label=Apply --title="Scrollspeed" --text "Mouse wheel speed:" --min-value=1 --max-value=100 --value="$CURRENT_VALUE" --step 1)

if [ "$NEW_VALUE" == "" ];
then exit 0
fi

sed -i "s/\($TARGET_KEY *Button4, *\).*/\1$NEW_VALUE/" ~/.imwheelrc # find the string Button4, and write new value.
sed -i "s/\($TARGET_KEY *Button5, *\).*/\1$NEW_VALUE/" ~/.imwheelrc # find the string Button5, and write new value.

cat ~/.imwheelrc
imwheel -kill
}

whennet () {
  # My internet sucks sometimes, so when its down I run this command. It uses a simple
  #  'ping google.com' to check if internet is working and sends an ubuntu notification
  #  when the ping succeeeds with code 0
  while [ true ]; do
    ping -c 1 google.com
    c=$?
    echo "[-] Exit code $c"
    if [ $c -eq 0 ]; then
      echo "[!] Success!"
      notify-send 'YOOOOO INTERNET IS BACK!!!'
      break
    fi
    sleep 3
  done
}

ENC_ITS=100000

enc () {
  openssl enc -aes-256-cbc -md sha512 -pbkdf2 -iter "$ENC_ITS" -salt -in "$1" -out "$1.enc"
}
dec () {
  openssl enc -d -aes-256-cbc -md sha512 -pbkdf2 -iter "$ENC_ITS" -salt -in "$@"
}

dec2cmd () {
  var=$(python -c 'import getpass;print(getpass.getpass("Enter pwd:"))')
  dec "$1" -k "$var" | eval "$2"
}

# gh plugin only works if I run this here...
compdef _gh gh
