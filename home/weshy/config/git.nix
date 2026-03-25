{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;

    userName = "weshford";
    userEmail = "95880628+weshford@users.noreply.github.com";

    extraConfig = {
      init.defaultBranch = "main";
      pull.rebase = false;
      core.editor = "nano";
    };
  };
}
