{ lib, osConfig, pkgs, ... }:

lib.mkIf (osConfig.programs.hyprland.enable or false) {
  gtk = {
    enable = true;
    theme = {
      name = "Adwaita";
      package = pkgs.gnome-themes-extra;
    };
    iconTheme = {
      name = "macOS Light";
      package = null;
    };
    font = {
      name = "JetBrains Mono";
      size = 11;
    };
  };

  qt = {
    enable = true;
    platformTheme.name = "gtk";
  };
}
