{ pkgs, ... }:

{
  home.packages = with pkgs; [
    heroic                      # game launcher wichtig für epic games 
    goverlay
    protonup-qt
    lutris                      # game launcher
  ];
}
