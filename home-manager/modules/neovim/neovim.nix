{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [
      {
        plugin = nvim-tree-lua;
        config = ''
          lua require("nvim-tree").setup({
            open_on_setup = true,
          })
        '';
      }
      {
        plugin = onedark-nvim;
        config = ''
          lua require("onedark").load()
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
