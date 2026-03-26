{ config, lib, pkgs, ... }:

let
  cfg = config.my.modules.hyprlandSupport;
in
{
  options.my.modules.hyprlandSupport.enable = lib.mkEnableOption "Hyprland support packages and utilities";

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      dunst
      rofi
      waybar
      hyprshot
      wf-recorder
      obs-studio
      xfce.thunar
      kdePackages.dolphin
      pavucontrol
      brightnessctl
      networkmanagerapplet
      networkmanager
      blueman
      power-profiles-daemon
      upower
      polkit_gnome
      libnotify
      xcur2png
      playerctl
    ];

    security.polkit.enable = true;
    services.power-profiles-daemon.enable = true;

    hardware.bluetooth.enable = true;
    services.blueman.enable = true;

    systemd.user.services.polkit-gnome = {
      description = "GNOME Polkit authentication agent";
      wantedBy = [ "graphical-session.target" ];
      wants = [ "graphical-session-pre.target" ];
      after = [ "graphical-session-pre.target" ];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
      };
    };
  };
}
