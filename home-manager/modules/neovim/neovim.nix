{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [
      {
        plugin = nvim-tree-lua;
        config = ''
          lua require("nvim-tree").setup()
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
      luafile ${./keys.lua}
    '';
  };
}
