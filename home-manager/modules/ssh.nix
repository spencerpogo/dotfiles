{ config, ... }: {
  programs.ssh = {
    enable = true;
    matchBlocks =
      let
        key = "${config.home.homeDirectory}/.ssh/id_ed25519";
        mkHost = user: hostname: {
          inherit user hostname;
          identityFile = [ key ];
        };
      in
      {
        vps = mkHost "spencer" "74.207.254.138";
        pwncollege = mkHost "hacker" "dojo.pwn.college";
      };
  };
}
