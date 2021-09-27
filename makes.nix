{ fetchNixpkgs
, outputs
, ...
}: {
  extendingMakesDir = "/nix";
  projectIdentifier = "pontix";
  inputs = rec {
    sources = import nix/sources.nix;
    nixpkgs = import sources.nixpkgs { overlays = [ ]; config = { }; };
  };
  formatNix = {
    enable = true;
    targets = [ "/" ];
  };
  formatMarkdown = {
    enable = true;
    doctocArgs = [ "-u" ];
    targets = [ "/nix/docs/README.md" ];
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
