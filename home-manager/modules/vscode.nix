{ pkgs, ... }:

{
  home.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "FiraCode" "Meslo" ]; })
    rls
  ];

  programs.vscode = {
    enable = true;
    # no tracking for me thanks
    package = pkgs.vscodium;

    extensions = (with pkgs.vscode-extensions; [
      matklad.rust-analyzer
      WakaTime.vscode-wakatime
      ms-python.vscode-pylance
      ms-vscode.cpptools
      ms-python.python
      ms-vsliveshare.vsliveshare
      vscodevim.vim
    ]) ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
      {
        name = "Nix";
        publisher = "bbenoist";
        version = "1.0.1";
        sha256 = "0zd0n9f5z1f0ckzfjr38xw2zzmcxg1gjrava7yahg5cvdcw6l35b";
      }
      {
        name = "better-toml";
        publisher = "bungcip";
        version = "0.3.2";
        sha256 = "08lhzhrn6p0xwi0hcyp6lj9bvpfj87vr99klzsiy8ji7621dzql3";
      }
      {
        name = "bracket-pair-colorizer-2";
        publisher = "CoenraadS";
        version = "0.2.0";
        sha256 = "0nppgfbmw0d089rka9cqs3sbd5260dhhiipmjfga3nar9vp87slh";
      }
      {
        name = "vscode-eslint";
        publisher = "dbaeumer";
        version = "2.1.20";
        sha256 = "0xk8pxv5jy89fshda845iswryvmgv0yxr11xsdbvd9zdczqhg7wc";
      }
      {
        name = "gitlens";
        publisher = "eamodio";
        version = "11.4.1";
        sha256 = "1gqkcv210h595rxwqsgwywjg2c2xnxdjlpqmgg091hd36g7jhcrs";
      }
      {
        name = "EditorConfig";
        publisher = "EditorConfig";
        version = "0.16.4";
        sha256 = "0fa4h9hk1xq6j3zfxvf483sbb4bd17fjl5cdm3rll7z9kaigdqwg";
      }
      {
        name = "andromeda";
        publisher = "EliverLara";
        version = "1.7.0";
        sha256 = "1899w5frankzg4g5va1cjv34gw9cdaxb3wdxqgzp694nffhzxb26";
      }
      {
        name = "prettier-vscode";
        publisher = "esbenp";
        version = "6.4.0";
        sha256 = "0k5x5d5axbpgyiy6j7q7d2rgxz6mg60sc0qgcca481srnca4j7x4";
      }
      {
        name = "go";
        publisher = "golang";
        version = "0.25.0";
        sha256 = "1g73bghi8knnvchkhdynvai034pnb95krks2xzhdhdac07dj227b";
      }
      {
        name = "vscode-graphql";
        publisher = "GraphQL";
        version = "0.3.16";
        sha256 = "120d5v0qpd1hhhz17xp0pgrmri13gdccz1xhcrn9pvbrxvsvp1il";
      }
      {
        name = "discord-vscode";
        publisher = "icrawl";
        version = "5.6.3";
        sha256 = "0z7niql0ax31mm03rkdknzm90s7ayqpz474cqx482iwdyi68ccfh";
      }
      {
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
        name = "material-icon-theme";
        publisher = "PKief";
        version = "4.6.0";
        sha256 = "0jid21l8mdh0bism7yl0awkbj9802fb880rkpnva43p61npybvcb";
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
      {
        name = "haskell";
        publisher = "haskell";
        version = "1.4.0";
        sha256 = "1jk702fd0b0aqfryixpiy6sc8njzd1brd0lbkdhcifp0qlbdwki0";
      }
      {
        name = "language-haskell";
        publisher = "justusadam";
        version = "3.4.0";
        sha256 = "0ab7m5jzxakjxaiwmg0jcck53vnn183589bbxh3iiylkpicrv67y";
      }
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
      "terminal.integrated.fontFamily" = "MesloLGS NF";
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
      "workbench.colorTheme" = "Andromeda Italic";
      "workbench.iconTheme" = "material-icon-theme";
      "gitlens.codeLens.enabled" = false;
      "coboleditor.enable_tabstop" = false;
      "coboleditor.format_on_return" = "uppercase";
      "coboleditor.intellisense_include_uppercase" = true;
      "coboleditor.intellisense_include_unchanged" = false;
      "python.dataScience.sendSelectionToInteractiveWindow" = false;
      "workbench.editorAssociations" = [{
        "viewType" = "jupyter.notebook.ipynb";
        "filenamePattern" = "*.ipynb";
      }];
      "rust-analyzer.diagnostics.disabled" = [ "unresolved-macro-call" ];
    };
  };
}
