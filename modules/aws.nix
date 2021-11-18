{
  config.files.cmds.awscli = true;
  config.files.cmds.yj = true;
  config.files.alias.stack-params = ''
    aws cloudformation describe-stacks \
      --stack-name $1 \
      --query "Stacks[].Parameters[]" \
      --output json| yj -jj
  '';
  config.files.alias.update-stack = ''
    aws cloudformation update-stack \
      --capabilities CAPABILITY_IAM CAPABILITY_NAMED_IAM \
      --stack-name $1 \
      --template-body file://$2 \
      --parameters `stack-params $1`
  '';
  config.files.alias.sync = ''
    aws s3 sync $@
  '';
  config.files.alias.check-credential = ''
    aws sts get-caller-identity
  '';
  config.files.alias.cache = ''
    nix copy --to s3://pontte-nix-cache $@ --no-check-sigs
  '';
}
