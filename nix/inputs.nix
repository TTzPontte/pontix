rec {
  sources = import ./sources.nix;
  nixpkgs = import sources.nixpkgs { overlays = [ ]; config = { }; };
  makes = nixpkgs.callPackage sources.makes { };
  pre-commit-hooks = nixpkgs.callPackage (sources.pre-commit-hooks + "/nix/default.nix") { inherit sources; };
  callPackage = nixpkgs.callPackage;
  lib = nixpkgs.lib;
}
