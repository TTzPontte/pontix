rec {
  ghEnv = parentKey: key: "\${{ ${parentKey}.${key} }}";
  ghSecret = key: ghEnv "secrets" key;
  toCron = { minute ? "*", hour ? "*", day ? "*", month ? "*", weekDay ? "*" }:
    with builtins; "${toString minute} ${toString hour} ${toString day} ${toString month} ${toString weekDay}";
  toSchedule = cronDef: [{ cron = toCron cronDef; }];
  substituters = "https://cache.nixos.org/ s3://pontte-nix-cache";
  trusted-public-keys = "${ghSecret "NIX_PUB_KEY"} ${ghSecret "PONTIX_PUB_KEY"}";
  installNix = {
    uses = "cachix/install-nix-action@v13";
    "with" = {
      nix_path = "nixpkgs=channel:nixos-unstable";
      extra_nix_config = ''
        
        substituters = ${substituters}
        trusted-public-keys = ${trusted-public-keys}

      '';
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
  pushCache = {
    name = "pushCache";
    run = makesIt "/pushCache";
    env.AWS_ACCESS_KEY_ID = ghSecret "TMP_AWS_ACCESS_KEY_ID";
    env.AWS_DEFAULT_REGION = ghSecret "TMP_AWS_DEFAULT_REGION";
    env.AWS_SECRET_ACCESS_KEY = ghSecret "TMP_AWS_SECRET_ACCESS_KEY";
    env.AWS_SESSION_TOKEN = ghSecret "TMP_AWS_SESSION_TOKEN";
    env.PONTIX_PRIV_KEY = ghSecret "PONTIX_PRIV_KEY";
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
