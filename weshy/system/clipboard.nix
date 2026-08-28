{ lib, osConfig, pkgs, ... }:

lib.mkIf (osConfig.programs.hyprland.enable or false) {
  home.packages = with pkgs; [
    cliphist
  ];

  systemd.user.services.cliphist = {
    Unit = {
      Description = "Clipboard history watcher (cliphist)";
      After = [ "graphical-session.target" ];
      PartOf = [ "graphical-session.target" ];
    };

    Service = {
      Type = "simple";
      ExecStart = ''
        ${pkgs.bash}/bin/bash -lc '\
          ${pkgs.wl-clipboard}/bin/wl-paste --type text --watch ${pkgs.cliphist}/bin/cliphist store &\
          ${pkgs.wl-clipboard}/bin/wl-paste --type image --watch ${pkgs.cliphist}/bin/cliphist store &\
          wait\
        '
      '';
      Restart = "always";
      RestartSec = 1;
    };

    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };
}