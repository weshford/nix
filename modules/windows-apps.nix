{ config, lib, pkgs, ... }:

let
  cfg = config.my.modules.windowsApps;
in
{
  options.my.modules.windowsApps.enable = lib.mkEnableOption "windows app compatibility runtime";

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      winetricks
      wineWowPackages.stable
    ];
  };
}