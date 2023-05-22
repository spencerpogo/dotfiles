{ ... }: {
  programs.vim = {
    enable = true;
    extraConfig = ''
      " Escape sequence on enter normal mode
      let &t_SI = "\e[6 q"
      " Escape sequence on enter insert mode
      let &t_EI = "\e[2 q"
    '';
  };
}
