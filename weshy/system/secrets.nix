{ config, lib, ... }:

lib.optionalAttrs (builtins.pathExists ../../secrets/secrets.yaml) {
  sops = {
    defaultSopsFile = ../../secrets/secrets.yaml;
    defaultSopsFormat = "yaml";
    age.keyFile = "${config.home.homeDirectory}/.config/sops/age/keys.txt";

    secrets = {
      "rclone/archived_dav_pass" = { };
    };
  };
}