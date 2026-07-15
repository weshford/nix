{ config, lib, pkgs, ... }:

let
  cfg = config.my.modules.gaming;
in
{
  options.my.modules.gaming.enable = lib.mkEnableOption "system-level gaming platform and performance tools";

  config = lib.mkIf cfg.enable {
    programs.steam = {
      enable = true;
      gamescopeSession.enable = true;
    };

    programs.gamemode.enable = true;

    services.sunshine = {
      enable = true;
      openFirewall = true;
      capSysAdmin = true;
    };

    environment.systemPackages = with pkgs; [
      mangohud
      chiaki-ng
      ryubing
    ];
  };
}