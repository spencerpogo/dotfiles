if (( $+commands[bat] )); then
  export MANPAGER="sh -c 'col -bx | bat -l man -p'"
fi

bindkey -v
export KEYTIMEOUT=1

# Use vim keys in tab complete menu:
zstyle ':completion:*' menu select
zmodload zsh/complist
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

# Emacs-style commands that I still want to use
bindkey -v '^[.' insert-last-word

# Change cursor shape for different vi modes.
# https://unix.stackexchange.com/a/614203/284442
# https://stackoverflow.com/a/42118416/9196137
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

# https://github.com/ohmyzsh/ohmyzsh/blob/f82aa819310752ad754c4ebfd1ae499285ee556e/lib/theme-and-appearance.zsh#L30
# For GNU ls, we use the default ls color theme. They can later be overwritten by themes.
if [[ -z "$LS_COLORS" ]]; then
  (( $+commands[dircolors] )) && eval "$(dircolors -b)"
fi

ls --color -d . &>/dev/null && alias ls='ls --color=tty' || { ls -G . &>/dev/null && alias ls='ls -G' }

# Take advantage of $LS_COLORS for completion as well.
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# Functions
copy () {
  # Command substitution removes trailing newlines, perfect for
  #  copying to clipboard
  local text
  if [ $# -ge 1 ]; then
    # read file given by first argument
    text=$(<$1)
  else
    # read from stdin
    text=$(<&0)
  fi
  # copy the text to the clipboard
  printf "%s" "$text" | xclip -sel c
}

nsh () {
  nix-shell -p "$@" --run zsh
  return "$?"
}

tc () { # transform clipboard
  paste | eval "$*" | copy
}

mkcd () {
  mkdir -p "$1"
  cd "$1"
}

ENC_ITS=100000
enc () {
  openssl enc -aes-256-cbc -md sha512 -pbkdf2 -iter "$ENC_ITS" -salt -in "$1" -out "$1.enc"
}
dec () {
  openssl enc -d -aes-256-cbc -md sha512 -pbkdf2 -iter "$ENC_ITS" -salt -in "$@"
}
dec2cmd () {
  local var=$(python -c 'import getpass;print(getpass.getpass("Enter pwd:"))')
  dec "$1" -k "$var" | eval "$2"
}
