set shell := ["bash", "-cu"]

HOST := "aspire"

default:
    @just --list

# Update flake inputs and lock file.
update:
    nix flake update

# Evaluate flake checks without building derivations.
check-flake:
    nix flake check --no-build --accept-flake-config

# Format Nix files.
format:
    nix fmt .

# Run statix lints.
lint:
    nix run nixpkgs#statix -- check .

# Detect dead Nix code.
check-dead-code:
    nix run nixpkgs#deadnix -- --fail .

# Run all quality checks.
check-all:
    just flake-check
    just lint
    just dead-code-check

# Build an install ISO from the flake host output.
build-iso:
    bash scripts/build-iso.sh

# SOPS: generate an age key under ~/.config/sops/age/keys.txt
sops-generate-agekey:
    mkdir -p ~/.config/sops/age
    nix shell nixpkgs#age -c age-keygen -o ~/.config/sops/age/keys.txt

# SOPS: show the public key
sops-show-publickey:
    nix shell nixpkgs#age -c age-keygen -y ~/.config/sops/age/keys.txt

# SOPS: edit your secrets file
sops-edit:
    nix shell nixpkgs#sops -c sops secrets/secrets.yaml

# SOPS: re-encrypt with updated keys
sops-updatekeys:
    nix shell nixpkgs#sops -c sops updatekeys secrets/secrets.yaml

# Interactive nix garbage collection helper.
garbagecollect:
    bash scripts/garbagecollect.sh
