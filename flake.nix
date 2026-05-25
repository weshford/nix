{
  description = "weshy NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    # temporary! until a patch for hyprplugins is available; currently builds fail bzw. dependencies are wrong
    nixpkgs-hyprland-plugins-fix.url = "github:NixOS/nixpkgs/231ea250eee538df1b939ca7899e0e80e7bcb08c";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-index-database = {
      url = "github:Mic92/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    helium = {
      url = "github:schembriaiden/helium-browser-nix-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    apple-fonts-nix = {
      url = "github:Lyndeno/apple-fonts.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, nixpkgs-hyprland-plugins-fix, home-manager, spicetify-nix, noctalia, nix-index-database, helium, sops-nix, apple-fonts-nix, ... }:
    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";

      userConfig = {
        username = "weshy";
        fullName = "weshy";
        gitName = "*weshford";
        gitEmail = "95880628+weshford@users.noreply.github.com";
        extraGroups = [ "networkmanager" "wheel" ];
      };

      hyprbarsPluginPackage = nixpkgs-hyprland-plugins-fix.legacyPackages.${system}.hyprlandPlugins.hyprbars;

      mkDevShell = system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        pkgs.mkShell {
          packages = with pkgs; [
            git
            just
            nixfmt-rfc-style
            statix
            deadnix
            nil
            nixd
            python3
            uv
            neovim
          ];
        };

    in
    {
      devShells = {
        ${system} = {
          default = mkDevShell system;
        };
      };

      nixosConfigurations.aspire = lib.nixosSystem {
        system = system;
        specialArgs = {
          inherit userConfig;
        };
        modules = [
          ./configuration.nix
          sops-nix.nixosModules.sops
          {
            nixpkgs.overlays = [
              (final: prev: {
                helium = helium.packages.${prev.system}.default;

                # openldap-2.6.13: test017-syncreplication-refresh is timing-sensitive and
                # fails on slow/sandboxed builders ("provider and consumer databases
                # differ"). The failure cascades into bottles / lutris / wine FHS envs
                # pulled in by the gaming hosts (BrightFalls, CauldronLake), killing their
                # full system builds in CI.
                #
                # Mirrors the upstream nixpkgs fix (still OPEN) by extending preCheck to
                # delete the offending test script, matching how other flaky openldap
                # tests (test022, test063, test076) are already skipped.
                #   Issue: https://github.com/NixOS/nixpkgs/issues/516392 (CLOSED, links to PR)
                #   Fix:   https://github.com/NixOS/nixpkgs/pull/516445   (OPEN as of 2026-05-05)
                # TODO: Drop this once unstable fixes. temporary fix only!
                openldap = prev.openldap.overrideAttrs (old: {
                  preCheck = (old.preCheck or "") + ''
                    rm -f tests/scripts/test017-syncreplication-refresh
                  '';
                });
              })
            ];
          }
          home-manager.nixosModules.home-manager
          nix-index-database.nixosModules.nix-index
          {
            home-manager.sharedModules = [
              noctalia.homeModules.default
              spicetify-nix.homeManagerModules.default
              sops-nix.homeManagerModules.sops
            ];
          }
          (import ./weshy/home.nix {
            inherit userConfig hyprbarsPluginPackage;
            spicetifyPkgs = spicetify-nix.legacyPackages.${system};
            appleFontsPkgs = apple-fonts-nix.packages.${system};
          })
        ];
      };
    };
}