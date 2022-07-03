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
    ];
    extraConfig = ''
      luafile keys.lua
    '';
  };
}
