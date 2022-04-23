{
  description = "build script for the lingua-franca alarm clock";

  inputs = {
    utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-21.05";
  };

  outputs = inputs@{self, utils, nixpkgs, ...}: 
    utils.lib.eachDefaultSystem (system: let 
      pkgs = nixpkgs.legacyPackages.${system};
      in rec {
        checks = packages;
        packages = {
          reveng = nixpkgs.legacyPackages.${system}.callPackage ./pkgs/reveng.nix {};
          gnuradio3_8 = nixpkgs.legacyPackages.${system}.callPackage ./pkgs/gnuradio.nix {};
        };
        overlay = (final: prev: {
          reveng = pkgs.callPackage ./pkgs/reveng.nix { };
          gnuradio3_8 = pkgs.callPackage ./pkgs/reveng.nix { };
        });
      }
    );
}