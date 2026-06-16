{ config, pkgs, ... }:

{
  boot = {
    extraModulePackages = [ config.boot.kernelPackages.evdi ];
    initrd.kernelModules = [ "evdi" ];
  };

  environment.systemPackages = with pkgs; [
    displaylink
  ];

  environment.variables = {
    WLR_EVDI_RENDER_DEVICE = "/dev/dri/by-path/pci-0000:01:00.0-card";
  };

  systemd.services.displaylink-server = {
    enable = true;
    requires = [ "systemd-udevd.service" ];
    after = [ "systemd-udevd.service" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.displaylink}/bin/DisplayLinkManager";
      User = "root";
      Group = "root";
      Restart = "on-failure";
      RestartSec = 5;
    };
  };
}