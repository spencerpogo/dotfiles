{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    zsh
    zsh-powerlevel10k
    zsh-fast-syntax-highlighting
    bat
  ];

  xdg.configFile.".p10k.zsh".source = ../configs/p10k.zsh;

  programs.zsh = {
    enable = true;
    initExtraFirst = ''
      # Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
      # Initialization code that may require console input (password prompts, [y/n]
      # confirmations, etc.) must go above this block; everything else may go below.
      if [[ -r "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
        source "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh"
      fi
    '';
    plugins = [
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
      {
        name = "fast-syntax-highlighting";
        src = pkgs.zsh-fast-syntax-highlighting;
        file = "share/zsh/site-functions/fast-syntax-highlighting.plugin.zsh";
      }
    ];
    initExtraBeforeCompInit = "source ${config.xdg.configHome}/.p10k.zsh";
    initExtra = ''
      # oh-my-zsh completion waiting dots
      expand-or-complete-with-dots() {
      print -Pn "%F{red}…%f"
        zle expand-or-complete
        zle redisplay
      }
      zle -N expand-or-complete-with-dots
      # Set the function as the default tab completion widget
      bindkey -M emacs "^I" expand-or-complete-with-dots
      bindkey -M viins "^I" expand-or-complete-with-dots
      bindkey -M vicmd "^I" expand-or-complete-with-dots

      # Pretty manpages with bat
      export MANPAGER="sh -c 'col -bx | ${pkgs.bat}/bin/bat -l man -p'"
    '';
  };
}
