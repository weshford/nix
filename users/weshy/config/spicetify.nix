{ pkgs, spicetifyPkgs, ... }:

let
  wmpotifySrc = pkgs.fetchFromGitHub {
    owner = "Ingan121";
    repo = "WMPotify";
    rev = "1.2.6";
    hash = "sha256-1unupMqpri+xdjJdHo2enpm7aBpbJUY/7btyHOx6CDk=";
  };
in
{
  programs.spicetify = {
    enable = true;
    colorScheme = "light";

    enabledExtensions = with spicetifyPkgs.extensions; [
      # adblock I already have premium lol but who knows ..
      hidePodcasts
    ];

    theme = {
      name = "WMPotify";
      src = "${wmpotifySrc}/theme/dist";
      injectCss = true;
      injectThemeJs = true;
      replaceColors = true;
      overwriteAssets = false;
    };
  };
}