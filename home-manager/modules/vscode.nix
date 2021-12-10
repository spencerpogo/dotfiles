{ pkgs, ... }:

# VS Codium (not code) config
{

  home.packages = [ pkgs.rls ];

  programs.vscode = {
    enable = true;
    # no tracking for me thanks
    package = pkgs.vscodium;

    # a couple of extensions
    # (I like a lot of different programming languages)
    # VS Code's extensibility is a major strength
    extensions = (with pkgs.vscode-extensions; [
      # Rust
      matklad.rust-analyzer
      # Code time tracking
      WakaTime.vscode-wakatime
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
      bbenoist.nix
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
    ]) ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
      {
        name = "better-toml";
        publisher = "bungcip";
        version = "0.3.2";
        sha256 = "08lhzhrn6p0xwi0hcyp6lj9bvpfj87vr99klzsiy8ji7621dzql3";
      }
      {
        name = "andromeda";
        publisher = "EliverLara";
        version = "1.7.0";
        sha256 = "1899w5frankzg4g5va1cjv34gw9cdaxb3wdxqgzp694nffhzxb26";
      }
      {
        name = "discord-vscode";
        publisher = "icrawl";
        version = "5.6.3";
        sha256 = "0z7niql0ax31mm03rkdknzm90s7ayqpz474cqx482iwdyi68ccfh";
      }
      /* {
           name = "import-sorter";
           publisher = "mike-co";
           version = "3.3.1";
           sha256 = "0z6biw0a06as63nb0pbxpk5j3dxwk7n1v14f4dk7f9hh7j69qp2s";
         }
         {
           name = "processing-formatter";
           publisher = "millennIumAMbiguity";
           version = "0.4.4";
           sha256 = "0fksfpf9b8x4mbl2d69hpii1105751s62dfmg30bv48aiabh6278";
         }
         {
           name = "LiveServer";
           publisher = "ritwickdey";
           version = "5.6.1";
           sha256 = "077arf3hsn1yb8xdhlrax5gf93ljww78irv4gm8ffmsqvcr1kws0";
         }
         {
           name = "language-pde";
           publisher = "Tobiah";
           version = "1.4.6";
           sha256 = "1v2gwwllk269hba2mc22scfr0bizwndgg7zm9wsxffm52pwfjqp9";
         }
         {
           name = "vscode-proto3";
           publisher = "zxh404";
           version = "0.5.4";
           sha256 = "08dfl5h1k6s542qw5qx2czm1wb37ck9w2vpjz44kp2az352nmksb";
         }
      */
    ];

    keybindings = [
      {
        key = "ctrl+space";
        command = "editor.action.triggerSuggest";
        when =
          "editorHasCompletionItemProvider && textInputFocus && !editorReadonly";
      }
      {
        key = "ctrl+space";
        command = "toggleSuggestionDetails";
        when = "suggestWidgetVisible && textInputFocus";
      }
      {
        key = "alt+k";
        command = "selectPrevSuggestion";
        when =
          "suggestWidgetMultipleSuggestions && suggestWidgetVisible && textInputFocus";
      }
      {
        key = "alt+j";
        command = "selectNextSuggestion";
        when =
          "suggestWidgetMultipleSuggestions && suggestWidgetVisible && textInputFocus";
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
      "editor.snippetSuggestions" = "top";
      "editor.fontFamily" = "FiraCode Nerd Font";
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
      "python.autoComplete.extraPaths" =
        [ "." "/home/scoder12/.pyenv/versions/3.8.2/lib/python3.8" ];
      "python.formatting.provider" = "black";
      "python.languageServer" = "Pylance";
      "terminal.integrated.fontFamily" = "MesloLGS Nerd Font 12";
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
      "editor.bracketPairColorization.enabled" = true;
      "colorize.languages" = [ "nix" ];
    };
  };
}
