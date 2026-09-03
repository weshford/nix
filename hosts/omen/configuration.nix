{ ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ../../modules/common.nix
      ../../modules/development.nix
      ../../modules/windows-apps.nix
      ../../modules/alias.nix
      ../../modules/basics.nix
    ];

  networking.hostName = "omen";

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
}
