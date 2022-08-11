{
  config,
  pkgs,
  ...
}:
# Having a rust compiler offline is nice
{
  home.packages = with pkgs; [cargo rustc rustfmt];

  home.sessionPath = ["${config.home.homeDirectory}/.cargo/bin"];
}
