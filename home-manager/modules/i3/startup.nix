{
  config,
  pkgs,
  lib,
  ...
}:
let
  inherit (import ./workspaces.nix)
    ws0
    ws1
    ws2
    ws3
    ws4
    ws5
    ws6
    ws7
    ws8
    ws9
    ;

  filename = "i3-startup.sh";
  createScriptPath = script: "${pkgs.writeShellScriptBin filename script}/bin/${filename}";
  scriptPath = createScriptPath ''
    i3-msg "workspace number ${ws0}; \
      append_layout ${./workspace-0.jsonc}; \
      workspace number ${ws1}; \
      append_layout ${./workspace-1.jsonc}"
    ${pkgs.obsidian}/bin/obsidian &
    until host example.com; do sleep 0.2; done
    ${config.programs.firefox.package}/bin/firefox &
    ${pkgs.discord}/bin/discord &
    ${pkgs.signal-desktop}/bin/signal-desktop &
  '';
in
{
  xsession.windowManager.i3.extraConfig = "exec --no-startup-id ${scriptPath}";
}
