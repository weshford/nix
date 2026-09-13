{ config, lib, pkgs, userConfig, ... }:

{
  imports =
    [
      ./omen/hardware-configuration.nix
      ./omen/gpu.nix
      ./modules/development.nix
      ./modules/alias.nix
      ./modules/basics.nix
    ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  nix.settings = {
    substituters = [
      "https://cache.nixos.org/"
      "https://kopuz.cachix.org/"
      "https://weshford.cachix.org/"
      "https://noctalia.cachix.org"
    ];
    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "kopuz.cachix.org-1:J2X3AnAYhKTJW5S3aCLoA1ckonQXVNZMQvhZA0YAufw="
      "weshford.cachix.org-1:J2X3AnAYhKTJW5S3aCLoA1ckonQXVNZMQvhZA0YAufw="
      "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
    ];
  };

  time.timeZone = "Europe/Berlin";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };

  services.xserver.xkb = {
    layout = "de";
    variant = "";
  };
  console.keyMap = "de";
  services.printing.enable = true;
  services.udisks2.enable = true;
  services.gvfs.enable = true;
  services.earlyoom.enable = true;
  services.gnome.gnome-keyring.enable = true;
  boot.initrd.systemd.enable = true;

  users.users.${userConfig.username} = {
    isNormalUser = true;
    description = userConfig.fullName or userConfig.username;
    extraGroups = userConfig.extraGroups or [ "networkmanager" "wheel" ];
  };

  environment.pathsToLink = [
    "/share/applications"
    "/share/xdg-desktop-portal"
  ];
  xdg.mime.enable = true;
  xdg.menus.enable = true;
  environment.etc."xdg/menus/applications.menu".text = builtins.readFile "${pkgs.kdePackages.plasma-workspace}/etc/xdg/menus/plasma-applications.menu";

  xdg.portal = {
    enable = true;
    config = {
      common.default = [ "gtk" ];
      hyprland = {
        default = [ "hyprland" "gtk" ];
        "org.freedesktop.impl.portal.ScreenCast" = "hyprland";
        "org.freedesktop.impl.portal.Screenshot" = "hyprland";
        "org.freedesktop.impl.portal.Settings" = "gtk";
      };
    };
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-hyprland
    ];
  };

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.permittedInsecurePackages = [
  ];

  my.modules.develop.enable = true;
  my.modules.shellAliases.enable = true;
  my.modules.basics.enable = true;

  services.displayManager.ly.enable = true;
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
  security.pam.services.hyprlock = { };

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  hardware.bluetooth.enable = true;
  services.upower.enable = true;
  services.power-profiles-daemon.enable = true;

  networking.networkmanager.enable = true;

  networking.hostName = "omen";

  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.windows = {
    windows = {
      title = "Windows 11";
      efiDeviceHandle = "FS0";
      sortKey = "y_windows";
    };
  };
  boot.loader.systemd-boot.edk2-uefi-shell = {
    enable = true;
    sortKey = "z_edk2";
  };
  boot.loader.efi.canTouchEfiVariables = true;

  system.stateVersion = "25.11";
}
