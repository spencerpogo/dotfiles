{ pkgs, ... }:
{
  services.xserver = {
    enable = true;

    # Configure keymap in X11
    xkb = {
      layout = "us";
      options = "caps:escape_shifted_capslock";
    };

    displayManager = {
      session = [
        {
          # name is purely cosmetic
          name = "i3";
          manage = "window";
          start = ''
            ${pkgs.runtimeShell} $HOME/.hm-xsession &
            waitPID=$!
          '';
        }
      ];
    };
  };

  services.displayManager = {
    # password is needed to unlock disk so don't ask again
    autoLogin = {
      enable = true;
      user = "spencer";
    };
    # also cosmetic, but should match above
    defaultSession = "none+i3";
  };

  fonts.packages = [ pkgs.noto-fonts-cjk-sans ];
}
