{ pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    withRuby = false;
    withPython3 = false;

    plugins = with pkgs.vimPlugins; [
      {
        plugin = nvim-tree-lua;
        type = "lua";
        config = ''
          require("nvim-tree").setup({
            open_on_setup = true,
            git = {
              ignore = false,
            },
          })
        '';
      }
      {
        plugin = onedark-nvim;
        type = "lua";
        config = ''
          require("onedark").load()
        '';
      }
    ];
    extraConfig = ''
      " truecolor
      set termguicolors
      " hybrid line numbers
      set number relativenumber
      luafile ${./keys.lua}
    '';
  };
}
