{ ... }:

{
  # Enable all home packages
  my.home.cli.enable = true;
  my.home.apps.enable = true;
  my.home.development.enable = true;
  my.home.gaming.enable = true;
  my.home.windowsApps.enable = true;

  imports = [
    # System integration
    ./system/symlinks.nix

    # Hyprland
    ./hyprland/default.nix

    # Configuration
    ./config/git.nix
    ./config/kitty.nix
    ./config/weathr.nix
    ./config/fastfetch.nix
    ./config/tahoetheme.nix

    # Packages
    ./packages/cli.nix
    ./packages/apps.nix
    ./packages/development.nix
    ./packages/gaming.nix
    ./packages/windows-apps.nix
  ];

  home.stateVersion = "25.11";

  my.home.hyprland.enable = true;
  my.home.waybar.enable = true;
  my.home.rofi.enable = true;
  my.home.dunst.enable = true;

  programs.home-manager.enable = true;
}
