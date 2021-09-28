{ makeScript
, inputs ? import ../inputs.nix
, outputs
, ...
}:
makeScript {
  name = "push-cache";
  searchPaths = {
    source = [ outputs."/secretsForAwsFromEnv/github" ];
    bin = [ inputs.nixpkgs.nix ];
  };
  entrypoint = ''
    ramtmp="$(mktemp -p /dev/shm/)"
    echo "$PONTIX_PRIV_KEY" > $ramtmp
    nix sign-paths --key-file $ramtmp --all
    nix copy --to s3://pontte-nix-cache --all
  '';
}
