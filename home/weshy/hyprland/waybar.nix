{ config, lib, ... }:

let
  cfg = config.my.home.waybar;
in
{
  options.my.home.waybar.enable = lib.mkEnableOption "Waybar top panel and macOS-style dock";

  config = lib.mkIf cfg.enable {
    programs.waybar = {
      enable = true;
      settings = {
        topBar = {
          layer = "top";
          position = "top";
          height = 32;
          margin = "8px 12px 0 12px";

          modules-left = [ "hyprland/workspaces" "hyprland/window" ];
          modules-right = [ "pulseaudio" "network" "bluetooth" "battery" "clock" "tray" ];

          "hyprland/workspaces" = {
            format = "{id}";
            on-click = "activate";
          };

          "hyprland/window" = {
            max-length = 45;
            separate-outputs = true;
          };

          pulseaudio = {
            scroll-step = 1;
            format = "󰕾 {volume}%";
            format-muted = "󰝟 muted";
            on-click = "pavucontrol";
          };

          network = {
            format-wifi = "󰤨 {essid}";
            format-ethernet = "󰈀 wired";
            format-disconnected = "󰤮 offline";
            on-click = "nm-connection-editor";
          };

          bluetooth = {
            format = " {status}";
            format-disabled = " off";
            on-click = "blueman-manager";
          };

          battery = {
            states = {
              warning = 30;
              critical = 15;
            };
            format = "{icon} {capacity}%";
            format-icons = [ "󰂎" "󰁺" "󰁼" "󰁾" "󰂀" "󰂂" "󰁹" ];
          };

          clock = {
            format = "󰥔 {:%a %d %b  %H:%M}";
            tooltip-format = "{:%A, %B %d, %Y (%H:%M)}";
          };

          tray = {
            spacing = 8;
          };
        };

        dockBar = {
          layer = "top";
          position = "bottom";
          height = 52;
          margin = "0 0 12px 0";

          modules-center = [ "hyprland/workspaces" "hyprland/window" ];

          "hyprland/workspaces" = {
            format = "{icon}";
            format-icons = {
              active = "";
              default = "";
            };
            persistent-workspaces = {
              "1" = [ ];
              "2" = [ ];
              "3" = [ ];
              "4" = [ ];
              "5" = [ ];
              "6" = [ ];
              "7" = [ ];
              "8" = [ ];
              "9" = [ ];
              "10" = [ ];
            };
          };

          "hyprland/window" = {
            max-length = 30;
            format = "{class}";
          };
        };
      };

      style = ''
        * {
          border: none;
          font-family: "JetBrainsMono Nerd Font";
          font-size: 12px;
          min-height: 0;
        }

        window#waybar {
          color: #EDEDED;
          background: transparent;
        }

        window#waybar.top {
          background-color: rgba(29, 27, 37, 0.86);
          border-radius: 12px;
        }

        window#waybar.bottom {
          background-color: rgba(29, 27, 37, 0.9);
          border-radius: 18px;
          margin: 0 auto;
          padding: 0 10px;
        }

        #workspaces button {
          color: #EDEDED;
          background: transparent;
          border-radius: 9px;
          padding: 0 8px;
          margin: 4px 2px;
        }

        #workspaces button.active {
          background: #6E5191;
        }

        #window,
        #pulseaudio,
        #network,
        #bluetooth,
        #battery,
        #clock,
        #tray {
          padding: 0 10px;
        }
      '';
    };
  };
}
