{ ... }:

{
  imports =
    [
      ./omen/hardware-configuration.nix
      ./omen/gpu.nix
      ./modules/common.nix
      ./modules/development.nix
      ./modules/windows-apps.nix
      ./modules/alias.nix
      ./modules/basics.nix
    ];

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
}
