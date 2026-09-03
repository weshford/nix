{ config, pkgs, ... }:

{
  xdg.configFile."noctalia/colors.json".source = ../dotfiles/noctalia/colors.json;
  xdg.configFile."noctalia/plugins.json".source = ../dotfiles/noctalia/plugins.json;

  xdg.configFile."noctalia/plugins/clipper/manifest.json".source = ../dotfiles/noctalia/plugins/clipper/manifest.json;
  xdg.configFile."noctalia/plugins/clipper/settings.json".source = ../dotfiles/noctalia/plugins/clipper/settings.json;

  xdg.configFile."noctalia/plugins/file-search/manifest.json".source = ../dotfiles/noctalia/plugins/file-search/manifest.json;
  xdg.configFile."noctalia/plugins/file-search/settings.json".source = ../dotfiles/noctalia/plugins/file-search/settings.json;

  xdg.configFile."noctalia/plugins/monitor-layout/manifest.json".source = ../dotfiles/noctalia/plugins/monitor-layout/manifest.json;
  xdg.configFile."noctalia/plugins/monitor-layout/settings.json".source = ../dotfiles/noctalia/plugins/monitor-layout/settings.json;

  xdg.configFile."noctalia/plugins/privacy-indicator/manifest.json".source = ../dotfiles/noctalia/plugins/privacy-indicator/manifest.json;
  xdg.configFile."noctalia/plugins/privacy-indicator/settings.json".source = ../dotfiles/noctalia/plugins/privacy-indicator/settings.json;

  xdg.configFile."noctalia/plugins/screen-toolfix/manifest.json".source = ../dotfiles/noctalia/plugins/screen-toolfix/manifest.json;
  xdg.configFile."noctalia/plugins/screen-toolfix/settings.json".source = ../dotfiles/noctalia/plugins/screen-toolfix/settings.json;

  xdg.configFile."noctalia/plugins/usb-drive-manager/manifest.json".source = ../dotfiles/noctalia/plugins/usb-drive-manager/manifest.json;
  xdg.configFile."noctalia/plugins/usb-drive-manager/settings.json".source = ../dotfiles/noctalia/plugins/usb-drive-manager/settings.json;

  xdg.configFile."noctalia/plugins/workspace-overview/manifest.json".source = ../dotfiles/noctalia/plugins/workspace-overview/manifest.json;

  xdg.configFile."vesktop/settings/settings.json".source = ../dotfiles/vesktop/settings/settings.json;
  xdg.configFile."vesktop/settings/quickCss.css".source = ../dotfiles/vesktop/settings/quickCss.css;
  xdg.configFile."vesktop/themes/Exponent.theme.css".source = ../dotfiles/vesktop/themes/Exponent.theme.css;
}
