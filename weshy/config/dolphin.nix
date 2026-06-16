{ ... }:

{
  xdg.configFile."kdeglobals".text = ''
    [General]
    TerminalApplication=kitty
    TerminalService=kitty.desktop
  '';

  xdg.mimeApps.defaultApplications = {
    "image/gif" = [ "helium.desktop" ];
    "image/jpeg" = [ "helium.desktop" ];
    "image/png" = [ "helium.desktop" ];
    "image/svg+xml" = [ "helium.desktop" ];
    "image/webp" = [ "helium.desktop" ];
  };
}