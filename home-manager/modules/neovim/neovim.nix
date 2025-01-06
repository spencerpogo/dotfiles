{ pkgs, ... }: {
  home.packages = with pkgs; [
    neovim
    lazygit
    ripgrep
    fd
  ];
}
