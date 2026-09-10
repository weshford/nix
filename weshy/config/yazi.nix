{ pkgs, ... }:

{
  programs.yazi = {
    enable = true;
    extraPackages = with pkgs; [
      sshfs
      fuse3
      fzf
    ];

    plugins.sshfs = {
      package = pkgs.fetchFromGitHub {
        owner = "uhs-robert";
        repo = "sshfs.yazi";
        rev = "a8b8903c0da5a4febe91713108a9b0c8a2749475";
        hash = "sha256-RYZ0wFkYfR/TfYntRipNPvpSl4gvtmNukLBQONRk1jU=";
      };
      setup = true;
    };

    keymap = {
      mgr.prepend_keymap = [
        {
          on = [ "M" "s" ];
          run = "plugin sshfs -- menu";
          desc = "Open SSHFS options";
        }
        {
          on = [ "<Esc>" "s" ];
          run = "plugin sshfs -- menu";
          desc = "Open SSHFS options";
        }
      ];
    };
  };
}
