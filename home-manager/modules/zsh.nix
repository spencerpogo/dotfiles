{ config, lib, pkgs, ... }:

with lib;

let HIST_SIZE = 32768; # 32**3
in {
  home.packages = with pkgs; [
    zsh-powerlevel10k
    zsh-fast-syntax-highlighting
    zsh-autosuggestions
  ];

  programs.zsh = {
    enable = true;
    oh-my-zsh = {
      # I have a mixed relationship with oh-my-zsh. On the one hand it slows
      #  down startup quite a bit, but on the other hand it *just works*. It
      #  has a lot of QoL fixes that are actively being maintainedm, such as
      #  xterm title support, git aliases, and ls colors. 
      # As long as I keep plugins light the couple seconds extra startup time is
      #  well worth the time it would take to configure manually.
      enable = true;
      plugins = [ "git" "sudo" ];
      extraConfig = ''
        DISABLE_UPDATE_PROMPT="true"
        COMPLETION_WAITING_DOTS="true"
      '';
    };
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
      ZSH_AUTOSUGGEST_STRATEGY=(history)
    '';
    plugins = [
      {
        name = "p10k-config";
        src = lib.cleanSource ../p10k-config;
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
    ];
    initExtra = ''
      # Pretty manpages with bat
      ${
        if config.programs.bat.enable then "" else "# "
      }export MANPAGER="sh -c 'col -bx | ${pkgs.bat}/bin/bat -l man -p'"

      # Functions
      tc () { # transform clipboard
        paste | eval "$*" | copy
      }

      mkcd () {
        mkdir -p "$1"
        cd "$1"
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

      if [ "$NEW_VALUE" = "" ]; then return 0; fi

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

      # Temp for non-nixos
      source /etc/profile.d/nix.sh && export NIX_PATH=$HOME/.nix-defexpr/channels''${NIX_PATH:+:}$NIX_PATH
    '';
    shellAliases = {
      # Clipboard
      copy = "xclip -sel c";
      c = "copy";
      paste = "xclip -o -sel c";
      p = "paste";
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
      nf = "find . -type f -name '*.nix' -exec nixfmt {} \;";
    };
  };
}
