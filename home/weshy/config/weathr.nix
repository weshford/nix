{ ... }:

{
  programs.weathr = {
    settings = {
      hide_hud = false;
      silent = false;
      location = {
        latitude = 52.5200;
        longitude = 13.4050;
        auto = true;
        hide = false;
        display = "mixed";
      };
      units = {
        temperature = "celsius";
        wind_speed = "kmh";
        precipitation = "mm";
      };
    };
  };
}
