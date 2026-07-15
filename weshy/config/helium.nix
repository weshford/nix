{ pkgs, config, ... }:

{
  home.packages = [ pkgs.helium ];

  home.file.".local/bin/helium" = {
    executable = true;
    text = ''
      #!${pkgs.bash}/bin/bash
      exec env GTK_USE_PORTAL=1 XDG_CURRENT_DESKTOP=Hyprland XDG_SESSION_DESKTOP=Hyprland NIXOS_OZONE_WL=1 ${pkgs.helium}/bin/helium "$@"
    '';
  };

  home.file.".local/share/applications/helium.desktop".text = ''
    [Desktop Entry]
    Type=Application
    Name=Helium
    Exec=${config.home.homeDirectory}/.local/bin/helium %U
    Icon=helium
    Terminal=false
    Categories=Network;WebBrowser;
    MimeType=text/html;x-scheme-handler/http;x-scheme-handler/https;
    StartupNotify=true
  '';
}