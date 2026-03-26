{ config, lib, ... }:

let
  cfg = config.my.home.dunst;
in
{
  options.my.home.dunst.enable = lib.mkEnableOption "Dunst notification daemon";

  config = lib.mkIf cfg.enable {
    services.dunst = {
      enable = true;
      settings = {
        global = {
          width = 360;
          height = 120;
          offset = "24x24";
          origin = "top-right";
          transparency = 10;
          frame_color = "#6E5191";
          font = "JetBrainsMono Nerd Font 10";
          corner_radius = 10;
          frame_width = 2;
          gap_size = 8;
        };

        urgency_low = {
          background = "#1D1B25";
          foreground = "#EDEDED";
          timeout = 3;
        };

        urgency_normal = {
          background = "#1D1B25";
          foreground = "#EDEDED";
          timeout = 5;
        };

        urgency_critical = {
          background = "#1D1B25";
          foreground = "#FF5F57";
          frame_color = "#FF5F57";
          timeout = 0;
        };
      };
    };
  };
}
