{ makeScript
, inputs ? import ../inputs.nix
, outputs
, ...
}:
makeScript {
  name = "check-aws-credentials";
  searchPaths = {
    source = [ outputs."/secretsForAwsFromEnv/github" ];
    bin = [ inputs.nixpkgs.awscli2 ];
  };
  entrypoint = ''
    aws sts get-caller-identity
  '';
}
