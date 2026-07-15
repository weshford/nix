{ pkgs, ... }:

{
  home.packages = [ pkgs.helium ];

  home.file.".local/share/applications/helium.desktop".text = ''
    [Desktop Entry]
    Type=Application
    Name=Helium
    Exec=env GTK_USE_PORTAL=1 NIXOS_OZONE_WL=1 ${pkgs.helium}/bin/helium %U
    Icon=helium
    Terminal=false
    Categories=Network;WebBrowser;
    MimeType=text/html;x-scheme-handler/http;x-scheme-handler/https;
    StartupNotify=true
  '';
}