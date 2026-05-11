set shell := ["bash", "-cu"]

HOST := "aspire"

default:
    @just --list

# Rebuild and switch to the active generation.
switch:
    sudo nixos-rebuild switch --flake .#{{HOST}}

# Rebuild in test mode.
test:
    sudo nixos-rebuild test --flake .#{{HOST}}

# Build and register as next boot generation.
boot:
    sudo nixos-rebuild boot --flake .#{{HOST}}

# Build the system configuration without switching.
build:
    sudo nixos-rebuild build --flake .#{{HOST}}

# Update flake inputs and lock file.
update:
    nix flake update

# Evaluate flake checks without building derivations.
flake-check:
    nix flake check --no-build --accept-flake-config

# Format Nix files.
fmt:
    nix fmt .

# Run statix lints.
lint:
    nix run nixpkgs#statix -- check .

# Detect dead Nix code.
dead-code-check:
    nix run nixpkgs#deadnix -- --fail .

# Run all quality checks.
quality:
    just flake-check
    just lint
    just dead-code-check

# Install pre-commit hooks.
hook-setup:
    pre-commit install

# Run pre-commit on all files.
hook-run:
    pre-commit run --all-files

# Update pre-commit hook versions.
hook-update:
    pre-commit autoupdate

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
