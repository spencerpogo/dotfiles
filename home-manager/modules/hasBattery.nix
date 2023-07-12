{ lib, ... }: {
  options = {
    home.hasBattery = lib.mkEnableOption "battery display";
  };
}
