{ pkgs, ... }:
{
  services.xserver = {
    enable = true;

    # Configure keymap in X11
    layout = "us";
    xkbOptions = "caps:escape_shifted_capslock";

    displayManager = {
      # password is needed to unlock disk so don't ask again
      autoLogin = {
        enable = true;
        user = "spencer";
      };
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
      # also cosmetic, but should match above
      defaultSession = "none+i3";
    };
  };
  fonts.fonts = [ pkgs.noto-fonts-cjk ];
}
