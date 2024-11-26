{ config
, lib
, pkgs
, ...
}:
# VS Codium (not code) config
{
  home.packages = [
    pkgs.nixpkgs-fmt
  ];

  programs.vscode = {
    enable = true;
    # no tracking for me thanks
    package = pkgs.vscodium;

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
          version = "1.8.1";
          sha256 = "sha256-O0WIewAExQTLlwstAglx1/6ukLntAqXxOEKRzw/5wKA=";
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
          version = "24.2.3";
          sha256 = "sha256-0QqA/lnXveY8OgoNV3LAGp2EwI11DKFoVTIxYUVH4e8=";
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

    userSettings = {
      "[html]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
      "[javascript]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
      "[javascriptreact]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
      "[json]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
      "[jsonc]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
      "[typescript]" = {
        "editor.codeActionsOnSave"."source.organizeImports" = true;
        "editor.defaultFormatter" = "esbenp.prettier-vscode";
      };
      "[typescriptreact]" = {
        "editor.codeActionsOnSave"."source.organizeImports" = true;
        "editor.defaultFormatter" = "esbenp.prettier-vscode";
      };
      "[rust]"."editor.tabSize" = 4;
      "[python]" = {
        "gitlens.codeLens.symbolScopes" = [ "!Module" ];
        "editor.wordBasedSuggestions" = false;
        "editor.tabSize" = 4;
      };
      "[c]" = {
        "editor.formatOnSave" = false;
        "editor.formatOnPaste" = false;
        "editor.formatOnType" = false;
      };
      "[css]" = { "editor.defaultFormatter" = "esbenp.prettier-vscode"; };
      "emmet.excludeLanguages" = [
        "markdown"
        "typescript"
        "typescriptreact"
        "javascript"
        "javascriptreact"
      ];
      "editor.acceptSuggestionOnCommitCharacter" = false;
      "editor.acceptSuggestionOnEnter" = "off";
      "editor.tabCompletion" = "on";
      "editor.snippetSuggestions" = "inline";
      "editor.fontFamily" = lib.mkIf config.fonts.fontconfig.enable "FiraCode Nerd Font";
      "terminal.integrated.fontFamily" = lib.mkIf config.fonts.fontconfig.enable "FiraCode Nerd Font";
      "editor.fontLigatures" = true;
      "editor.formatOnSave" = true;
      "editor.formatOnType" = true;
      "editor.maxTokenizationLineLength" = 200;
      "editor.tabSize" = 2;
      "explorer.confirmDelete" = false;
      "explorer.confirmDragAndDrop" = false;
      "files.exclude" = {
        "**/.classpath" = true;
        "**/.factorypath" = true;
        "**/.next" = true;
        "**/.project" = true;
        "**/.settings" = true;
        "**/__pycache__" = true;
      };
      "git.enableSmartCommit" = true;
      "go.formatTool" = "goimports";
      "go.lintOnSave" = "workspace";
      "java.semanticHighlighting.enabled" = true;
      "keyboard.dispatch" = "keyCode";
      "python.analysis.logLevel" = "Trace";
      "python.autoComplete.extraPaths" = [ "." "/home/scoder12/.pyenv/versions/3.8.2/lib/python3.8" ];
      "python.formatting.provider" = "black";
      "python.languageServer" = "Pylance";
      "vim.handleKeys" = {
        "<C-a>" = false;
        "<C-c>" = false;
        "<C-n>" = false;
        "<C-o>" = false;
        "<C-s>" = false;
        "<C-v>" = false;
        "<C-x>" = false;
        "<C-z>" = false;
        "<C-g>" = false;
        "<C-f>" = false;
        "<C-k>" = false;
        "<C-p>" = false;
      };
      "workbench.colorTheme" = "Andromeda Italic Bordered";
      "workbench.iconTheme" = "material-icon-theme";
      "gitlens.codeLens.enabled" = false;
      "coboleditor.enable_tabstop" = false;
      "coboleditor.format_on_return" = "uppercase";
      "coboleditor.intellisense_include_uppercase" = true;
      "coboleditor.intellisense_include_unchanged" = false;
      "python.dataScience.sendSelectionToInteractiveWindow" = false;
      "workbench.editorAssociations"."*.ipynb" = "jupyter.notebook.ipynb";
      "rust-analyzer.diagnostics.disabled" = [ "unresolved-macro-call" ];
      "rust-analyzer.inlayHints.maxLength" = 10;
      "typescript.preferences.importModuleSpecifier" = "relative";
      "javascript.preferences.importModuleSpecifier" = "relative";
      "typescriptreact.preferences.importModuleSpecifierEnding" = "js";
      "javascript.preferences.importModuleSpecifierEnding" = "js";
      "editor.bracketPairColorization.enabled" = true;
      "colorize.languages" = [ "nix" ];
      "editor.autoClosingBrackets" = "beforeWhitespace";
      "editor.inlayHints.enabled" = "offUnlessPressed";
      "css.lint.unknownAtRules" = "ignore";
      "svelte.enable-ts-plugin" = true;
    };
  };
}
