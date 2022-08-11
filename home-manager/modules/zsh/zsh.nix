{
  config,
  lib,
  pkgs,
  ...
}:
# my zsh config with powerlevel10k
with lib; let
  HIST_SIZE = 32768; # 32**3
  zshSrc = lib.cleanSource ../zsh;
in {
  home.packages = with pkgs; [
    zsh-powerlevel10k
    zsh-fast-syntax-highlighting
    zsh-autosuggestions
  ];

  programs.direnv.enableZshIntegration = true;

  programs.zsh = {
    enable = true;
    defaultKeymap = "viins";
    history = {
      size = HIST_SIZE;
      save = HIST_SIZE;
      ignoreSpace = true;
    };
    initExtraFirst = ''
      # Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
      # Initialization code that may require console input (password prompts, [y/n]
      # confirmations, etc.) must go above this block; everything else may go below.
      typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet
      if [[ -r "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
        source "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh"
      fi

      # Autosuggestions
      ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=80
      ZSH_AUTOSUGGEST_STRATEGY=(history)
    '';
    plugins = [
      {
        name = "p10k-config";
        src = zshSrc;
        file = "p10k.zsh";
      }
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
      {
        name = "quick-nix-shell";
        src = zshSrc;
        file = "zsh-quick-nix-shell.zsh";
      }
      {
        name = "zshrc-misc";
        src = zshSrc;
        file = "zshrc.zsh";
      }
    ];
    shellAliases = {
      # Clipboard
      c = "copy";
      paste = "xclip -o -sel c";
      p = "paste";
      pimg = "paste -t image/png";
      # Traversal
      ".." = "cd ..";
      "..." = "cd ../..";
      "...." = "cd ../../..";
      # Text mainpulation
      sl = "tr -d \\n";
      tjson = "jq -Rr tojson";
      bse = "base64 -w 0";
      bsd = "base64 -d";
      # Tasks
      nf = "find . -type f -name '*.nix' -exec nixfmt {} \\;";
      # misc
      cmdv = "command -v";
      rf = "readlink -f";
    };
  };
}
