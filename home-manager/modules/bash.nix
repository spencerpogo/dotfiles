{ pkgs, ... }:

{
  # I don't use bash much but it is a good fallback in case zsh is having issues
  programs.bash.enable = true;
}