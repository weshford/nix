{ ... }:

{
  xdg.userDirs.enable = true;

  xdg.mimeApps = {
    enable = true;
    associations.added = {
      "inode/directory" = [ "org.kde.dolphin.desktop" ];
      "application/gzip" = [ "org.kde.ark.desktop" ];
      "application/vnd.rar" = [ "org.kde.ark.desktop" ];
      "application/x-7z-compressed" = [ "org.kde.ark.desktop" ];
      "application/x-bzip" = [ "org.kde.ark.desktop" ];
      "application/x-bzip2" = [ "org.kde.ark.desktop" ];
      "application/x-compressed-tar" = [ "org.kde.ark.desktop" ];
      "application/x-gtar" = [ "org.kde.ark.desktop" ];
      "application/x-lzip" = [ "org.kde.ark.desktop" ];
      "application/x-tar" = [ "org.kde.ark.desktop" ];
      "application/x-xz" = [ "org.kde.ark.desktop" ];
      "application/zip" = [ "org.kde.ark.desktop" ];
      "image/gif" = [ "helium.desktop" ];
      "image/jpeg" = [ "helium.desktop" ];
      "image/png" = [ "helium.desktop" ];
      "image/svg+xml" = [ "helium.desktop" ];
      "image/webp" = [ "helium.desktop" ];
    };
    defaultApplications = {
      "inode/directory" = [ "org.kde.dolphin.desktop" ];
      "application/gzip" = [ "org.kde.ark.desktop" ];
      "application/vnd.rar" = [ "org.kde.ark.desktop" ];
      "application/x-7z-compressed" = [ "org.kde.ark.desktop" ];
      "application/x-bzip" = [ "org.kde.ark.desktop" ];
      "application/x-bzip2" = [ "org.kde.ark.desktop" ];
      "application/x-compressed-tar" = [ "org.kde.ark.desktop" ];
      "application/x-gtar" = [ "org.kde.ark.desktop" ];
      "application/x-lzip" = [ "org.kde.ark.desktop" ];
      "application/x-tar" = [ "org.kde.ark.desktop" ];
      "application/x-xz" = [ "org.kde.ark.desktop" ];
      "application/zip" = [ "org.kde.ark.desktop" ];
      "image/gif" = [ "helium.desktop" ];
      "image/jpeg" = [ "helium.desktop" ];
      "image/png" = [ "helium.desktop" ];
      "image/svg+xml" = [ "helium.desktop" ];
      "image/webp" = [ "helium.desktop" ];
    };
  };

  xdg.configFile."kdeglobals".text = ''
    [General]
    TerminalApplication=kitty
    TerminalService=kitty.desktop
  '';
}
