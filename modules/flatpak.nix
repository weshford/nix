{ config, lib, pkgs, ... }:

let
  cfg = config.my.modules.flatpak;
in
{
  options.my.modules.flatpak.enable = lib.mkEnableOption "Flatpak support and tooling";

  config = lib.mkIf cfg.enable {
    services.flatpak.enable = true;

    environment.systemPackages = with pkgs; [
      flatpak
    ];
  };
}