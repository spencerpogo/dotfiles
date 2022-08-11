{config, ...}: {
  programs.ssh = {
    enable = true;
    matchBlocks = let
      key = "${config.home.homeDirectory}/.ssh/id_ed25519";
      mkHost = user: hostname: {
        inherit user hostname;
        identityFile = [key];
      };
    in {
      vps = mkHost "spencer" "173.255.213.75";
      pwncollege = mkHost "hacker" "dojo.pwn.college";
    };
  };
}
