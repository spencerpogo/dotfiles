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

rfw () {
  readlink -f $(which "$1")
}

# "ls grep": quickly search for a pattern in a directory's files
lsg () {
  if [[ "$#" -lt 1 ]]; then
    echo "Usage: $0 <pat> [dir]" >&2
    return 1
  fi
  find "${2:-.}" -maxdepth 1 -name "*$1*"
  return "$?"
}

pypr () {
  local code="$1"
  shift
  python -c "print($code)" "$@"
  return "$?"
}
