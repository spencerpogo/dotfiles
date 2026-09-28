{
  config,
  lib,
  pkgs,
  ...
}:
# VS Codium (not code) config
{
  home.packages = [
    pkgs.nixfmt
  ];

  # use vscodium open-source fork
  programs.vscodium = {
    enable = true;

    profiles.default = {
      # a couple of extensions
      # (I like a lot of different programming languages)
      # VS Code's extensibility is a major strength
      extensions =
        (with pkgs.vscode-extensions; [
          # Rust
          rust-lang.rust-analyzer
          # Code time tracking
          wakatime.vscode-wakatime
          # unfree microsoft python shit
          ms-python.vscode-pylance
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
            version = "1.10.0";
            sha256 = "sha256-W84m9b3Dzq2LjUpa/0hzSWbVokaxI4IDEaCySWDF9Uk=";
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
