{ makeScript
, inputs ? import ../inputs.nix
, outputs
, ...
}:
makeScript {
  name = "pushCache";
  searchPaths = {
    bin = [
      inputs.nixpkgs.nix
    ];
  };
  entrypoint = ''
    nix sign-path --key-file <(echo "$PONTIX_PRIV_KEY") --all
    nix copy --to s3://pontte-nix-cache --all
  '';
}
