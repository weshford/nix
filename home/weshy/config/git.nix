{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;

    userName = "yungztrunks";
    userEmail = "95880628+yungztrunks@users.noreply.github.com";

    extraConfig = {
      init.defaultBranch = "main";
      pull.rebase = false;
      core.editor = "nano";
    };
  };
}
