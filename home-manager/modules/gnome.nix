{ ... }:

{
  imports = [ ./gnome-terminal.nix ];

  dconf.enable = true;

  dconf.settings = {
    # Make caps lock an additional escape for vim, but shift+caps lock normal caps lock
    # I used to use "swap caps lock and escape" but my games wouldn't recognize the
    #  rebind, causing me to not be able to press escape in those games.
    # Plus, in the rare case that I do end up needing to use caps lock I have that
    #  option, unlike if I chose "caps lock is an additional esc"
    "org/gnome/desktop/input-sources"."xkb-options" =
      [ "caps:escape_shifted_capslock" ];
  };
}
