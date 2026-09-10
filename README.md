# nixos config

readme used to be a tiny bit more detailed but since I removed most of the features that are worth sharing (with strangers) about this config.. there isnt anything left really

branch `legacy` is the repo with the multiuser / multihost template I created and never used. if you want to _nix run_ my system, you'll need to adjust the branch. other than that, it's working fine.

branch `aspire` is the repo of an older laptop

branch `kde-master` is just the repo of an older generation. it kinda looks like macos iirc

the system is configured as:
- `omen`: `.#nixosConfigurations.omen`

build/switch on target host:
- `sudo nixos-rebuild build --flake .#omen`
- `sudo nixos-rebuild switch --flake .#omen`

screenshots soon maybe
