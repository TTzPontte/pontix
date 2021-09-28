rec {
  ghEnv = parentKey: key: "\${{ ${parentKey}.${key} }}";
  ghSecret = key: ghEnv "secrets" key;
  toCron = { minute ? "*", hour ? "*", day ? "*", month ? "*", weekDay ? "*" }:
    with builtins; "${toString minute} ${toString hour} ${toString day} ${toString month} ${toString weekDay}";
  toSchedule = cronDef: [{ cron = toCron cronDef; }];
  installNix = {
    uses = "cachix/install-nix-action@v13";
    "with" = {
      nix_path = "nixpkgs=channel:nixos-unstable";
    };
  };
  checkout = {
    uses = "actions/checkout@v2";
    "with".persist-credentials = false;
  };
  installMakes = {
    name = "installMakes";
    run = with builtins;"nix-env -if ${(fromJSON (readFile ./sources.json)).makes.url}";
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
    , stepsBefore ? [ installNix installMakes checkout ]
    , stepsAfter ? [ notifyStep ]
    , ...
    }: {
      ${name} = (builtins.removeAttrs args [ "name" ]) // {
        runs-on = "ubuntu-latest";
        steps = stepsBefore ++ steps ++ stepsAfter;
      };
    };
  makes = args: "m ${args}";
  makesIt = args: makes ". ${args}";
}
