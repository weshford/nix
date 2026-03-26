{ config, lib, pkgs, ... }:

let
  cfg = config.my.modules.hyprland;
in
{
  options.my.modules.hyprland.enable = lib.mkEnableOption "Hyprland wayland compositor";

  config = lib.mkIf cfg.enable {
    programs.hyprland = {
      enable = true;
      xwayland.enable = true;
    };

    environment.systemPackages = with pkgs; [
      hyprland
      hyprlock
      hypridle
      hyprshot
      wl-clipboard
      wl-clip-persist
      xdg-utils
      wf-recorder
    ];

    environment.sessionVariables = {
      NIXOS_OZONE_WL = "1";
      QT_QPA_PLATFORM = "wayland";
      GDK_BACKEND = "wayland";
      SDL_VIDEODRIVER = "wayland";
      CLUTTER_BACKEND = "wayland";
    };
  };
}
