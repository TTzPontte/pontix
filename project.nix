{config, ...}:{ 
  imports = [
    ./modules/notify-slack.nix
    ./modules/aws.nix
    ./modules/git.nix
    ./modules/docs.nix
  ];
  # enable .gitignore creation
  files.gitignore.enable = true;
  # add hello.yaml to .gitignore
  files.gitignore.pattern."github-actions" = true;
  # copy contents from https://github.com/github/gitignore
  gh-actions.notify-slack.enable = true;
  gh-actions.notify-slack.post-deploy = "tag-it";
}
