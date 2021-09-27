{ inputs ? import ./nix/inputs.nix
, pre-commit-hooks ? inputs.callPackage ./nix/pre-commit.nix { inherit inputs; }
}:
let
  nixpkgs = inputs.nixpkgs;
  makes = inputs.makes;
  shellHook = pre-commit-hooks.shellHook;
in
nixpkgs.mkShell {
  buildInputs = with nixpkgs; [ nix niv makes jq awscli2 gh git aws-sam-cli ];
  shellHook = ''
    ${shellHook}
  '';
}
