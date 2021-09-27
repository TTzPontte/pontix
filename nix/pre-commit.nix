{ inputs ? import ./inputs.nix
, src ? ../.
}:
inputs.pre-commit-hooks.run {
  src = ../.;
  hooks = {
    nixpkgs-fmt.enable = true;
  };
}
