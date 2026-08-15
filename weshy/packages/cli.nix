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

    # for screen-toolkit
    grim
    hyprpicker
    slurp
    tesseract
    imagemagick
    zbar
    curl
    bc
    wf-recorder
    wl-screenrec
    swappy
    satty
    translate-shell
  ];
}
