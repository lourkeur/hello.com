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

    outputsBuilder = channels: {
      defaultPackage = channels.nixos.callPackage nix/package.nix { };
      devShell = channels.nixos.callPackage nix/devshell.nix { };
    };
  };
}
