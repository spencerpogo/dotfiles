_myfuncs=()

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
_myfuncs+=copy

nsh () {
  nix-shell -p "$@" --run zsh
  return "$?"
}
_myfuncs+=nsh

tc () { # transform clipboard
  paste | eval "$*" | copy
}
_myfuncs+=tc

mkcd () {
  mkdir -p "$1"
  cd "$1"
}
_myfuncs+=mkcd

ENC_ITS=100000
enc () {
  openssl enc -aes-256-cbc -md sha512 -pbkdf2 -iter "$ENC_ITS" -salt -in "$1" -out "$1.enc"
}
_myfuncs+=enc
dec () {
  openssl enc -d -aes-256-cbc -md sha512 -pbkdf2 -iter "$ENC_ITS" -salt -in "$@"
}
_myfuncs+=dec

rfw () {
  readlink -f $(which "$1")
}
_myfuncs+=rfw

# "ls grep": quickly search for a pattern in a directory's files
lsg () {
  if [[ "$#" -lt 1 ]]; then
    echo "Usage: $0 <pat> [dir]" >&2
    return 1
  fi
  find "${2:-.}" -maxdepth 1 -name "*$1*"
}
_myfuncs+=lsg

pypr () {
  if [[ "$#" -lt 1 ]]; then
    printf 'Usage: %s <expr> [args...]' "$0" >&2
    return 1
  fi
  local expr="$1"
  shift
  python -c "print($expr)" "$@"
}
_myfuncs+=pypr

timedelta () {
  if [[ "$#" -lt 1 ]]; then
    printf "Usage: %s <args>" "$0" >&2
    return 1
  fi
  python -c 'import sys; from datetime import timedelta;'\
'print(eval("timedelta(" + sys.argv[1] + ")"))' "$@"
}
_myfuncs+=timedelta

nixbin () {
  if [[ "$#" -lt 1 ]]; then
    printf '%s: no binary specified' "$0"
    return 1
  fi
  nix-locate --top-level --minimal --at-root --whole-name "/bin/$1"
}
_myfuncs+=nixbin

nixattr () {
  nix-build --no-out-link '<nixpkgs>' -A "$@"
}
_myfuncs+=nixattr

cdd () {
  cd "$(dirname "$@")"
}
_myfuncs+=cdd

myfuncs () {
  printf '%s\n' "$_myfuncs[@]" | sort
}
_myfuncs+=myfuncs
