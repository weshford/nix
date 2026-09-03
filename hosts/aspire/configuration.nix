{ ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ../../modules/common.nix
      ../../aspire/displaylink.nix
      ../../aspire/gpu.nix
      ../../modules/development.nix
      ../../modules/windows-apps.nix
      ../../modules/alias.nix
      ../../modules/basics.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 3;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "aspire";
}
