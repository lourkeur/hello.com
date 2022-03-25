# The flake file is the entry point for nix commands
{
  description = "Various experiments around the Cosmo LibC";

  # Inputs are how Nix can use code from outside the flake during evaluation.
  inputs.devshell.url = "github:numtide/devshell";
  inputs.fup.url = "github:gytis-ivaskevicius/flake-utils-plus/v1.3.1";
  inputs.flake-compat.url = "github:edolstra/flake-compat";
  inputs.flake-compat.flake = false;
  inputs.nixos.url = "nixpkgs/nixos-unstable";

  # Outputs are the public-facing interface to the flake.
  outputs = inputs@{ self, fup, ... }: fup.lib.mkFlake {

    inherit self inputs;

    sharedOverlays = [
      inputs.devshell.overlay
    ];

    channels.nixos.patches = [
      (inputs.nixos.legacyPackages.x86_64-linux.fetchpatch {
        url = "https://github.com/NixOS/nixpkgs/pull/165342/commits/46de36b92a7dcaf0cbe86225d622200ca3486e05.patch";
        hash = "sha256-QIepQsNtzqF9mDg65Qf+27F0ALPxQzojPfqBK9OKR7k=";
      })
    ];

    outputsBuilder = channels: {
      defaultPackage = channels.nixos.callPackage nix/package.nix { };
      devShell = channels.nixos.callPackage nix/devshell.nix { };
    };
  };
}
