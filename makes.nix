{ outputs
, ...
}: {
  extendingMakesDir = "/nix";
  projectIdentifier = "pontix";
  inputs = import ./nix/inputs.nix;
  formatNix = {
    enable = true;
    targets = [ "/" ];
  };
  secretsForAwsFromEnv = {
    github = {
      accessKeyId = "AWS_ACCESS_KEY_ID";
      secretAccessKey = "AWS_SECRET_ACCESS_KEY";
      defaultRegion = "AWS_DEFAULT_REGION";
      sessionToken = "AWS_SESSION_TOKEN";
    };
  };
}
