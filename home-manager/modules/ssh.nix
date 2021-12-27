{ config, ... }:
{
  programs.ssh = {
    enable = true;
    matchBlocks = {
      vps = {
        user = "spencer";
        hostname = "173.255.213.75";
        identityFile = ["${config.home.homeDirectory}/.ssh/id_ed25519"];
      };
    };
  };
}