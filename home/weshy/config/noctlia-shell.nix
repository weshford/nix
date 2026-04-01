{ config, pkgs, lib, ... }:

{
  programs.noctlia-shell = {
    enable = true;
    settings = {
      # General appearance
      theme = "dark";
      accent_color = "#6e5194";
      
      # Panel configuration
      panel = {
        position = "top";
        height = 32;
        transparency = 0.95;
      };

      # Taskbar
      taskbar = {
        enabled = true;
        position = "top";
      };

      # Workspace
      workspaces = 10;
      
      # Animations
      animations = {
        enabled = true;
        duration = 200;
      };

      # Keybindings
      keybindings = {
        show_overview = "Super_L";
        close_window = "Super+Q";
        switch_workspace_left = "Super+Comma";
        switch_workspace_right = "Super+Period";
      };
    };
  };

  # Create noctlia-shell configuration directory if needed
  xdg.configHome = "${config.home.homeDirectory}/.config";
}
