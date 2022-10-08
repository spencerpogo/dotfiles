#!/usr/bin/env zsh

ns() {
  local pkgs=()
  local cmd=()

  while [[ $# -gt 0 ]]; do
    local arg=$1
    shift
    case $arg in
    -r)
      cmd+=("$@")
      break
      ;;
    *) pkgs+=("$arg") ;;
    esac
  done

  if [[ ${#cmd[@]} -eq 0 ]]; then
    nix-shell -p "${pkgs[@]}" --run zsh
    local ret=$?
    if [[ $ret -eq 0 ]]; then
      # interactive shell exited successfully.
      # avoid user having to type "exit" again
      exit 0
    fi
    # nix command failed, don't exit the shell
    return $ret
  fi

  nix-shell -p "${pkgs[@]}" --run "$(printf "'%s' " "${cmd[@]}")"
  return $?
}

# Modified from the built-in nix-shell zsh completions.
_ns() {
  _nix-common-options
  local -a _nix_shell_opts=(
    '--command[Run a command instead of starting an interactive shell]:Command:_command_names'
    '--exclude[Do not build any dependencies which match this regex]:Regex:( )'
    '--pure[Clear the environment before starting the interactive shell]'
    # '--run[Run a command in a non-interactive shell instead of starting an interactive shell]:Command:_command_names'
    '*'{--run,-r}'[Run a command in a non-interactive shell instead of starting an interactive shell]:Command:_command_names'
    '*'{--attr,-A}"[setup a build shell for package]:package:_nix_complete_attr_paths"
  )
  #local norm_arguments='*:Paths:_nix_path'
  local norm_arguments='*:Packages: _nix_attr_paths "import <nixpkgs>"'
  local word
  for word in $words; do
    case "$word" in
    #--packages | -[^-]#p[^-]#)
    #  norm_arguments='*:Packages: _nix_attr_paths "import <nixpkgs>"'
    #  break
    #  ;;
    --expr | -[^-]#E[^-]#) norm_arguments='*:Expression:' ;;
    esac
  done
  _arguments \
    $__nix_boilerplate_opts \
    $__nix_common_opts \
    $_nix_shell_opts \
    $norm_arguments - '(group)' \
    $__nix_expr_opts # {--packages,-p}'[run with packages from <nixpkgs> (override usinge -I)]'
}
compdef _ns ns
