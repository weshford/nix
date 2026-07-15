{ pkgs, config, ... }:

{
  programs.kitty.enable = true;
  programs.firefox.enable = false;
  programs.obs-studio.enable = true;

  home.packages = with pkgs; [
    vlc
    discord
    vesktop
    qbittorrent
    qdirstat
    mpv
    chafa
    libsixel
  ];

  home.file.".local/bin/discord" = {
    executable = true;
    text = ''
      #!${pkgs.bash}/bin/bash
      exec env GTK_USE_PORTAL=1 XDG_CURRENT_DESKTOP=Hyprland XDG_SESSION_DESKTOP=Hyprland NIXOS_OZONE_WL=1 ELECTRON_OZONE_PLATFORM_HINT=auto ${pkgs.discord}/bin/Discord --enable-features=UseOzonePlatform --ozone-platform=wayland "$@"
    '';
  };

  home.file.".local/share/applications/discord.desktop".text = ''
    [Desktop Entry]
    Type=Application
    Name=Discord
    Exec=${config.home.homeDirectory}/.local/bin/discord %U
    Icon=discord
    Terminal=false
    Categories=Network;Chat;InstantMessaging;
    MimeType=x-scheme-handler/discord;x-scheme-handler/discord-https;
    StartupNotify=true
  '';
}
