{ fetchNixpkgs
, outputs
, ...
}: {
  extendingMakesDir = "/nix";
  projectIdentifier = "pontix";
  formatNix = {
    enable = true;
    targets = [ "/" ];
  };
  inputs = rec {
    sources = import nix/sources.nix;
    nixpkgs = import sources.nixpkgs { overlays = [ ]; config = { }; };
  };
  lintGitCommitMsg = {
    enable = true;
    branch = "main";
  };
  secretsForAwsFromEnv = {
    github = {
      accessKeyId = "AWS_ACCESS_KEY_ID";
      secretAccessKey = "AWS_SECRET_ACCESS_KEY";
      defaultRegion = "AWS_DEFAULT_REGION";
    };
  };
}
