rec {
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
  notifyStep = {
    name = "notify devs";
    run = makesIt "/notifySlack";
    env.GIPHY_TOKEN = ghSecret "GIPHY_TOKEN";
    env.GIF_TAG = ghSecret "GIF_TAG";
    env.SLACK_BOT_CHANNEL = ghSecret "SLACK_BOT_CHANNEL";
    env.SLACK_BOT_TOKEN_GIT_ACTION = ghSecret "SLACK_BOT_TOKEN_GIT_ACTION";
  };
  mkJob =
    args@{ name ? "build"
    , steps ? [ ]
    , stepsBefore ? [ installNix ]
    , stepsAfter ? [ notifyStep ]
    , ...
    }: {
      ${name} = (builtins.removeAttrs args [ "name" ]) // {
        runs-on = "ubuntu-latest";
        steps = stepsBefore ++ steps ++ stepsAfter;
      };
    };
  makes = args: "nix-shell run 'm ${args}'";
  makesIt = args: makes ". ${args}";
}
