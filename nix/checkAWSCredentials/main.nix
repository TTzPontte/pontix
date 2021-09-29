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
    cat $AWS_CONFIG_FILE
    echo "$AWS_DEFAULT_REGION"
    echo "$AWS_SESSION_TOKEN"
    echo "$AWS_ACCESS_KEY_ID"
    echo "$AWS_SECRET_ACCESS_KEY"
    aws configure set aws_session_token "$AWS_SESSION_TOKEN"
    aws sts get-caller-identity
  '';
}
