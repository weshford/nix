{
  description = "weshy NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/master";
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
    luffy = {
      url = "github:DemonKingSwarn/luffy";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, spicetify-nix, noctalia, nix-index-database, helium, sops-nix, apple-fonts-nix, luffy, ... }:
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

      hyprbarsPluginPackage = nixpkgs.legacyPackages.${system}.hyprlandPlugins.hyprbars;

    in
    {
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
                helium = helium.packages.${system}.default;
                luffy = luffy.packages.${system}.default;

                # openldap-2.6.13: the syncreplication tests are timing-sensitive and fail
                # on slow / sandboxed builders ("provider and consumer databases differ").
                # First test017 fell over, then surgically skipping it just exposed the
                # next one (test019-syncreplication-cascade). The failure cascades into
                # bottles / lutris / wine FHS envs pulled in by the gaming hosts
                # (BrightFalls, CauldronLake), killing their full system builds in CI.
                #
                # Disabling the check phase entirely until upstream lands a real fix —
                # going test-by-test is whack-a-mole.
                #   Issue: https://github.com/NixOS/nixpkgs/issues/516392 (CLOSED, links to PR)
                #   Fix:   https://github.com/NixOS/nixpkgs/pull/516445   (OPEN as of 2026-05-05,
                #          only patches test017 — won't fully unbreak us; revisit when
                #          upstream addresses test019 too)
                # Drop this override once nixos-unstable ships a build that passes checks.
                openldap = prev.openldap.overrideAttrs (_: {
                  doCheck = false;
                });

                # obs-studio-32.1.2: GCC internal compiler error during frontend build
                # ("Please submit a full bug report"). Triggered by aggressive hardening
                # flags on complex C++ code. Disabling stack protector works around the ICE.
                #   Error snippet: gt_ggc_mx_lang_tree_node internal error during compilation
                # TODO: Drop this override once GCC fix propagates to unstable.
                obs-studio = prev.obs-studio.overrideAttrs (old: {
                  hardeningDisable = (old.hardeningDisable or []) ++ [ "stackprotector" ];
                });

                #TODO: out of memory issue ..
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
