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
    echo "$AWS_SESSION_TOKEN"
    echo "$AWS_ACCESS_KEY_ID"
    echo "$AWS_SECRET_ACCESS_KEY"
    aws configure set aws_session_token "$AWS_SESSION_TOKEN"
    aws configure set aws_default_region "$AWS_DEFAULT_REGION"
    aws configure set aws_access_key_id "$AWS_ACCESS_KEY_ID"
    aws configure set aws_secret_key "$AWS_SECRET_ACCESS_KEY"
    echo $AWS_SHARED_CREDENTIALS_FILE
    cat $AWS_SHARED_CREDENTIALS_FILE
    echo $AWS_CONFIG_FILE
    cat $AWS_CONFIG_FILE
    aws sts get-caller-identity
  '';
}
