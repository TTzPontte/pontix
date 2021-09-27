{ outputs
, ...
}: {
  extendingMakesDir = "/nix";
  projectIdentifier = "pontios";
  inputs = import ./nix/inputs.nix;
  formatNix = {
    enable = true;
    targets = [ "/" ];
  };
  formatMarkdown = {
    enable = true;
    doctocArgs = [ "-u" ];
    targets = [ "/" ];
  };
  lintGitCommitMsg = {
    enable = true;
    branch = "master";
  };
  secretsForAwsFromEnv = {
    github = {
      accessKeyId = "AWS_ACCESS_KEY_ID";
      secretAccessKey = "AWS_SECRET_ACCESS_KEY";
      defaultRegion = "AWS_DEFAULT_REGION";
    };
  };
}
