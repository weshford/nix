{ pkgs, ... }:

{
  home.packages = with pkgs; [
    htop
    fd
    fzf
    ripgrep
    eza
    btop
    yazi
    unrar
    unzip
    zip
    p7zip
    ffmpeg
    yt-dlp
  ];
}
