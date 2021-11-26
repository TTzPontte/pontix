{config, ...}:{ 
  imports = [
    ./modules/notify-slack.nix
    ./modules/aws.nix
    ./modules/git.nix
    ./modules/docs.nix
  ];
  # enable .gitignore creation
  config.files.gitignore.enable = true;
  # add hello.yaml to .gitignore
  config.files.gitignore.pattern."github-actions" = true;
  # copy contents from https://github.com/github/gitignore
  config.gh-actions.notify-slack.enable = true;
  config.gh-actions.notify-slack.post-deploy = "tag-it";
}
