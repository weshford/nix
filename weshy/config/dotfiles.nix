{ config, pkgs, ... }:

{
  xdg.configFile."noctalia/config.toml".source = ../dotfiles/noctalia/config.toml;

  xdg.configFile."vesktop/settings/settings.json".source = ../dotfiles/vesktop/settings/settings.json;
  xdg.configFile."vesktop/settings/quickCss.css".source = ../dotfiles/vesktop/settings/quickCss.css;
  xdg.configFile."vesktop/themes/Exponent.theme.css".source = ../dotfiles/vesktop/themes/Exponent.theme.css;
}
