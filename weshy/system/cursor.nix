{ pkgs, ... }:

{
  home.packages = [ pkgs.apple-cursor ];

  home.pointerCursor = {
    enable = true;
    name = "macOS";
    package = pkgs.apple-cursor;
    size = 24;
    x11.enable = true;
  };
}
