{ pkgs, ... }:

{
  home.packages = with pkgs; [
    wget
    screen
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
    ani-cli
  ];
}
