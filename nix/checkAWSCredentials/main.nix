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
    cat $AWS_SHARED_CREDENTIALS_FILE
    echo "$AWS_DEFAULT_RESION"
    aws sts get-caller-identity
  '';
}
