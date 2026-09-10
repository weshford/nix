{ config, lib, pkgs, ... }:

{
  boot.blacklistedKernelModules = [ "nouveau" ];

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    package = config.boot.kernelPackages.nvidiaPackages.stable;
    open = true;
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    nvidiaSettings = true;

    prime = {
      sync.enable = true;
      amdgpuBusId = "PCI:5:0:0";
      nvidiaBusId = "PCI:1:0:0";
    };
  };

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  nixpkgs.config.cudaSupport = true;

  environment.systemPackages = with pkgs; [
    cudaPackages.cudatoolkit
  ];
}