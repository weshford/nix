{ config, lib, pkgs, ... }:

let
  cfg = config.my.home.hyprland;
  powerMenu = pkgs.writeShellScriptBin "hypr-power-menu" ''
    CHOICE=$(printf "Lock\nSuspend\nReboot\nShutdown\nLogout" | rofi -dmenu -i -p "Power")
    case "$CHOICE" in
      Lock) hyprlock ;;
      Suspend) systemctl suspend ;;
      Reboot) systemctl reboot ;;
      Shutdown) systemctl poweroff ;;
      Logout) hyprctl dispatch exit ;;
      *) exit 0 ;;
    esac
  '';
in
{
  options.my.home.hyprland.enable = lib.mkEnableOption "Hyprland configuration";

  config = lib.mkIf cfg.enable {
    home.packages = [ powerMenu ];

    wayland.windowManager.hyprland = {
      enable = true;
      xwayland.enable = true;
      systemd.enable = true;

      settings = {
        monitor = [ ",preferred,auto,1" ];

        general = {
          gaps_in = 5;
          gaps_out = 10;
          border_size = 2;
          "col.active_border" = "rgba(6E5191ff)";
          "col.inactive_border" = "rgba(3D3352ff)";
          resize_on_border = true;
          allow_tearing = false;
          layout = "dwindle";
        };

        input = {
          kb_layout = "de";
          follow_mouse = 1;
          mouse_refocus = true;
          sensitivity = 0.0;
        };

        decoration = {
          rounding = 10;
          blur = {
            enabled = true;
            size = 5;
            passes = 2;
          };
          drop_shadow = true;
          shadow_range = 4;
          shadow_render_power = 3;
          "col.shadow" = "rgba(1a1a1aee)";
        };

        animations = {
          enabled = true;
          first_launch_animation = true;
          bezier = [
            "myBezier, 0.05, 0.9, 0.1, 1.05"
          ];
          animation = [
            "windows, 1, 7, myBezier"
            "windowsOut, 1, 7, default, popin 80%"
            "border, 1, 10, default"
            "fade, 1, 7, default"
            "workspaces, 1, 6, default"
          ];
        };

        dwindle = {
          pseudotile = true;
          preserve_split = true;
        };

        master = {
          new_status = "slave";
        };

        misc = {
          force_default_wallpaper = 0;
          disable_hyprland_logo = true;
        };

        bind = [
          "ALT, space, exec, rofi -show drun"
          "SUPER SHIFT, s, exec, hyprshot -m region"
          "SUPER SHIFT, f, exec, hyprshot -m window"
          "SUPER SHIFT, c, exec, hyprshot -m region --raw | wl-copy"
          "SUPER, return, exec, kitty"
          "SUPER, q, killactive"
          "SUPER, f, fullscreen, 0"
          "SUPER, v, togglefloating"
          "SUPER, j, togglesplit"
          "SUPER, left, movefocus, l"
          "SUPER, right, movefocus, r"
          "SUPER, up, movefocus, u"
          "SUPER, down, movefocus, d"
          "SUPER SHIFT, left, movewindow, l"
          "SUPER SHIFT, right, movewindow, r"
          "SUPER SHIFT, up, movewindow, u"
          "SUPER SHIFT, down, movewindow, d"
          "SUPER, 1, workspace, 1"
          "SUPER, 2, workspace, 2"
          "SUPER, 3, workspace, 3"
          "SUPER, 4, workspace, 4"
          "SUPER, 5, workspace, 5"
          "SUPER, 6, workspace, 6"
          "SUPER, 7, workspace, 7"
          "SUPER, 8, workspace, 8"
          "SUPER, 9, workspace, 9"
          "SUPER, 0, workspace, 10"
          "SUPER SHIFT, 1, movetoworkspace, 1"
          "SUPER SHIFT, 2, movetoworkspace, 2"
          "SUPER SHIFT, 3, movetoworkspace, 3"
          "SUPER SHIFT, 4, movetoworkspace, 4"
          "SUPER SHIFT, 5, movetoworkspace, 5"
          "SUPER SHIFT, 6, movetoworkspace, 6"
          "SUPER SHIFT, 7, movetoworkspace, 7"
          "SUPER SHIFT, 8, movetoworkspace, 8"
          "SUPER SHIFT, 9, movetoworkspace, 9"
          "SUPER SHIFT, 0, movetoworkspace, 10"
          ", XF86AudioRaiseVolume, exec, pactl set-sink-volume @DEFAULT_SINK@ +5%"
          ", XF86AudioLowerVolume, exec, pactl set-sink-volume @DEFAULT_SINK@ -5%"
          ", XF86AudioMute, exec, pactl set-sink-mute @DEFAULT_SINK@ toggle"
          ", XF86MonBrightnessUp, exec, brightnessctl set +5%"
          ", XF86MonBrightnessDown, exec, brightnessctl set 5%-"
          "SUPER SHIFT, l, exec, hyprlock"
          "SUPER SHIFT, p, exec, hypr-power-menu"
        ];

        bindr = [
          ", SUPER_L, exec, rofi -show drun"
        ];

        bindm = [
          "SUPER, mouse:272, movewindow"
          "SUPER, mouse:273, resizewindow"
        ];

        "exec-once" = [
          "waybar"
          "dunst"
          "nm-applet"
          "blueman-applet"
        ];
      };
    };
  };
}
