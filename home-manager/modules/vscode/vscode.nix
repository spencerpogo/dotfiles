{
  config,
  lib,
  pkgs,
  ...
}:
# VS Codium (not code) config
{
  home.packages = [
    pkgs.nixfmt-rfc-style
  ];

  programs.vscode = {
    enable = true;
    # no tracking for me thanks
    package = pkgs.vscodium;

    profiles.default = {
      # a couple of extensions
      # (I like a lot of different programming languages)
      # VS Code's extensibility is a major strength
      extensions =
        (with pkgs.vscode-extensions; [
          # Rust
          rust-lang.rust-analyzer
          # Code time tracking
          #WakaTime.vscode-wakatime
          # unfree microsoft python shit
          ms-python.vscode-pylance
          # I don't know why this is here I don't do C++
          ms-vscode.cpptools
          # python (essential)
          # too stupid to pick up on nix-installed black sadly
          ms-python.python
          ms-vsliveshare.vsliveshare
          ms-toolsai.jupyter
          vscodevim.vim
          jnoortheen.nix-ide
          dbaeumer.vscode-eslint
          eamodio.gitlens
          editorconfig.editorconfig
          esbenp.prettier-vscode
          golang.go
          graphql.vscode-graphql
          pkief.material-icon-theme
          haskell.haskell
          justusadam.language-haskell
          kamikillerto.vscode-colorize
          redhat.java
          bungcip.better-toml
          usernamehw.errorlens
        ])
        ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
          {
            name = "andromeda";
            publisher = "EliverLara";
            version = "1.8.2";
            sha256 = "sha256-ur+zXuKluJ0DZS5/S4RaomibnJuFy4SE4tk9i+9+ORc=";
          }
          {
            name = "discord-vscode";
            publisher = "icrawl";
            version = "5.8.0";
            sha256 = "sha256-IU/looiu6tluAp8u6MeSNCd7B8SSMZ6CEZ64mMsTNmU=";
          }
          {
            name = "vscode-wakatime";
            publisher = "WakaTime";
            version = "24.6.0";
            sha256 = "sha256-VyyF+AAZviKOtLWVvGMhGh9tyQMse+6nUc7X57zzUBI=";
          }
        ];

      keybindings = [
        {
          key = "ctrl+space";
          command = "editor.action.triggerSuggest";
          when = "editorHasCompletionItemProvider && textInputFocus && !editorReadonly";
        }
        {
          key = "ctrl+space";
          command = "toggleSuggestionDetails";
          when = "suggestWidgetVisible && textInputFocus";
        }
        {
          key = "alt+k";
          command = "selectPrevSuggestion";
          when = "suggestWidgetMultipleSuggestions && suggestWidgetVisible && textInputFocus";
        }
        {
          key = "alt+j";
          command = "selectNextSuggestion";
          when = "suggestWidgetMultipleSuggestions && suggestWidgetVisible && textInputFocus";
        }
        {
          command = "acceptSelectedSuggestion";
          key = "tab";
          when = "suggestWidgetVisible && textInputFocus";
        }
      ];

      userSettings = ./settings.json;
    };
  };
}
