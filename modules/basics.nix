{ config, lib, pkgs, ... }:

let
  cfg = config.my.modules.basics;
in
{
  options.my.modules.basics.enable = lib.mkEnableOption "basic system configuration and utilities.. must needs etc";

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      # vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
      wayland-utils
      wl-clipboard
      kitty
      kdePackages.dolphin                     # explorer
      kdePackages.ark                         # so wie 7z
      kdePackages.qtwayland                   # Qt Wayland platform plugin kp rr
      kdePackages.plasma-integration          # kp rr
      kdePackages.qtsvg                       # kp rr
      kdePackages.kservice                    # kp rr
      kdePackages.partitionmanager            # für formattierungen usw
      kdePackages.kate                        # notepad / editor
      shared-mime-info                        # kp rr
    ];
  };
}