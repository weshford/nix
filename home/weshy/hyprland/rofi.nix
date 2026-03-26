{ config, lib, pkgs, ... }:

let
  cfg = config.my.home.rofi;
in
{
  options.my.home.rofi.enable = lib.mkEnableOption "Rofi launcher with Spotlight-style theme";

  config = lib.mkIf cfg.enable {
    programs.rofi = {
      enable = true;
      package = pkgs.rofi;

      theme = ''
        * {
          bg-col: #1D1B25;
          bg-col-light: #2D2B35;
          border-col: #6E5191;
          selected-col: #6E5191;
          fg-col: #EDEDED;
          fg-col2: #F5F5F5;
          grey: #3D3352;
          width: 760px;
          font: "JetBrainsMono Nerd Font 14";
        }

        element-text, element-icon, mode-switcher {
          background-color: inherit;
          text-color: inherit;
        }

        window {
          location: north;
          anchor: north;
          y-offset: 120px;
          height: 420px;
          border: 3px;
          border-color: @border-col;
          background-color: @bg-col;
          border-radius: 20px;
        }

        mainbox {
          children: [ inputbar, listview ];
          background-color: @bg-col;
          padding: 20px;
        }

        inputbar {
          background-color: @bg-col-light;
          border-radius: 10px;
          padding: 10px 20px;
          children: [ prompt, entry ];
          margin-bottom: 20px;
        }

        listview {
          columns: 1;
          lines: 8;
          cycle: true;
          dynamic: true;
          scrollbar: false;
        }

        element {
          padding: 10px;
          background-color: @bg-col;
          text-color: @fg-col;
          border-radius: 10px;
          margin-bottom: 5px;
        }

        element.selected {
          background-color: @selected-col;
          text-color: @fg-col2;
        }
      '';

      extraConfig = {
        modi = "drun,run,window";
        show-icons = true;
        icon-theme = "macOS-Light";
        drun-display-format = "{icon} {name}";
      };
    };
  };
}
