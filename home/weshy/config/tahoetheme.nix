{ ... }:

{
  home.file = {
    ".local/bin/plasma-tahoe-layout" = {
      source = ../dotfiles/bin/plasma-tahoe-layout;
    };

    ".config/autostart/plasma-tahoe-layout.desktop".source = ../dotfiles/autostart/plasma-tahoe-layout.desktop;
  };
}
