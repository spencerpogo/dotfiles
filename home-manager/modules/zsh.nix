{ config, pkgs, ... }:

let 
  HIST_SIZE = 32768; # 32**3
in {
  home.packages = with pkgs; [
    zsh
    zsh-powerlevel10k
    zsh-fast-syntax-highlighting
    zsh-autosuggestions
    bat
  ];

  xdg.configFile.".p10k.zsh".source = ../configs/p10k.zsh;

  programs.zsh = {
    enable = true;
    history = {
      size = HIST_SIZE;
      save = HIST_SIZE;
      ignoreSpace = true;
    };
    initExtraFirst = ''
      # Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
      # Initialization code that may require console input (password prompts, [y/n]
      # confirmations, etc.) must go above this block; everything else may go below.
      if [[ -r "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
        source "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh"
      fi

      # Autosuggestions
      ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=80
      ZSH_AUTOSUGGEST_STRATEGY=(match_prev_cmd history completion)
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
      {
        name = "autosuggestions";
        src = pkgs.zsh-autosuggestions;
        file = "share/zsh-autosuggestions/zsh-autosuggestions.zsh";
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
      # end oh-my-zsh completion waiting dots

      # Pretty manpages with bat
      export MANPAGER="sh -c 'col -bx | ${pkgs.bat}/bin/bat -l man -p'"
    '';
    shellAliases = {
      # Clipboard
      copy = "xclip -sel c";
      c = "copy";
      paste = "xclip -o -sel c";
      p = "paste";
    };
  };
}
