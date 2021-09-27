let
  ghEnv = parentKey: key: "\${{ ${parentKey}.${key} }}";
  ghSecret = key: ghEnv "secrets" key;
  toCron = { minute ? "*", hour ? "*", day ? "*", month ? "*", weekDay ? "*" }:
    with builtins; "${toString minute} ${toString hour} ${toString day} ${toString month} ${toString weekDay}";
  toSchedule = cronDef: [{ cron = toCron cronDef; }];
  installNix = {
    uses = "cachix/install-nix-action@v13";
    "with" = {
      "install_url" = "https://nixos-nix-install-tests.cachix.org/serve/i6laym9jw3wg9mw6ncyrk6gjx4l34vvx/install";
      "install_options" = "--tarball-url-prefix https://nixos-nix-install-tests.cachix.org/serve";
      "extra_nix_config" = "experimental-features = nix-command flakes";
    };
  };
  mkJob = name: runs-on: steps: {
    "${name}" = {
      inherit runs-on;
      steps = [ installNix ] ++ steps;
    };
  };
  makes = args: "nix-shell run 'm ${args}'";
  makesIt = args: makes ". ${args}";
in
builtins.toJSON {
  name = "CI";
  on.push.branches = [ "master" ];
  on.schedule = toSchedule { hour = 3; };
  jobs = mkJob "update" "ubuntu-latest" [
    {
      name = "update aws keys";
      run = makesIt "/update-aws-keys";
      env.GITHUB_TOKEN = ghSecret "GITHUB_TOKEN";
      env.AWS_ACCESS_KEY_ID = ghSecret "AWS_ACCESS_KEY_ID";
      env.AWS_DEFAULT_REGION = ghSecret "AWS_DEFAULT_REGION";
      env.AWS_SECRET_ACCESS_KEY = ghSecret "AWS_SECRET_ACCESS_KEY";
    }
    {
      name = "notify devs";
      run = makes "/notify-slack";
      env.GIPHY_TOKEN = ghSecret "GIPHY_TOKEN";
      env.SLACK_BOT_CHANNEL = ghSecret "SLACK_BOT_CHANNEL";
      env.SLACK_BOT_TOKEN_GIT_ACTION = ghSecret "SLACK_BOT_TOKEN_GIT_ACTION";
    }
  ];
}
