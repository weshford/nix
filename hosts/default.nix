{ ... }:

{
  # Shared host defaults.
  networking.networkmanager.enable = true;

  my.modules.desktopSpecialisations = {
    buildHyprland = true;
    buildNiri = true;
    buildKde = true;
  };
}
