{ pkgs, ... }:

{
  # enable nix managaing fonts (some GUI modules such as vscode and gnome-terminal need
  #  them)
  fonts.fontconfig.enable = true;

  home.packages = [
    (pkgs.nerdfonts.override {
      fonts = [
        # coding font with amazing ligatures for editor
        "FiraCode"
        # Terminal font
        "Meslo"
      ];
    })
    pkgs.font-awesome_5
  ];

  xdg.configFile."fontconfig/conf.d/80-scale-fontawesome.conf".text = ''
    <?xml version='1.0'?>
    <!-- Increase FontAwesome icons size. A hacky way to make i3 workspace icons bigger. -->
    <!DOCTYPE fontconfig SYSTEM 'fonts.dtd'>
    <fontconfig>
      <!-- https://unix.stackexchange.com/a/41110/284442 -->
      <match target="font">
          <test name="family">
              <string>Font Awesome 5 Free</string>
          </test>
          <edit name="pixelsize" mode="assign">
              <times><name>pixelsize</name>, <double>1.5</double></times>
          </edit>
      </match>
      <match target="font">
          <test name="family">
              <string>Font Awesome 5 Brands</string>
          </test>
          <edit name="pixelsize" mode="assign">
              <times><name>pixelsize</name>, <double>1.5</double></times>
          </edit>
      </match>
    </fontconfig>
  '';
}
