{ 
  sources ? import nix/sources.nix,
  pkgs ? import sources.nixpkgs { overlays = [] ; config = {}; },
  makes ? import sources.makes {}
}:
pkgs.mkShell {
  buildInputs = with pkgs; [ nix niv makes jq awscli2 gh git aws-sam-cli ];
  shellHook = "m . /";
}
