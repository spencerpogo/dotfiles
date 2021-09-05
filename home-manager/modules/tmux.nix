{ config, pkgs, ... }:

{
  programs.tmux= {
    enable = true;
    shell = if config.programs.zsh.enable then "${pkgs.zsh}/bin/zsh" else null;
    # Must be (screen|tmux)(-256color)?
    terminal = "screen-256color";
  };
}
