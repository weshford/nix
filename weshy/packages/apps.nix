{ pkgs, ... }:

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

  home.file.".local/share/applications/discord.desktop".text = ''
    [Desktop Entry]
    Type=Application
    Name=Discord
    Exec=env GTK_USE_PORTAL=1 NIXOS_OZONE_WL=1 ELECTRON_OZONE_PLATFORM_HINT=auto ${pkgs.discord}/bin/Discord --enable-features=UseOzonePlatform --ozone-platform=wayland %U
    Icon=discord
    Terminal=false
    Categories=Network;Chat;InstantMessaging;
    MimeType=x-scheme-handler/discord;x-scheme-handler/discord-https;
    StartupNotify=true
  '';
}
