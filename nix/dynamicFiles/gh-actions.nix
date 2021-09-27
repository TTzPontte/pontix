{ toFileYaml, ... }:
let
  lib = import ../gh-actions.nix;
in
with lib;
rec {
  name = "ci-cd.yaml";
  to = "./.github/workflows/";
  file = toFileYaml name {
    name = "CI";
    on.push.branches = [ "master" ];
    jobs = mkJob {
      name = "update";
      steps = [
        {
          name = "notify devs";
          run = makesIt "/notifySlack";
          env.GIPHY_TOKEN = ghSecret "GIPHY_TOKEN";
          env.SLACK_BOT_CHANNEL = ghSecret "SLACK_BOT_CHANNEL";
          env.SLACK_BOT_TOKEN_GIT_ACTION = ghSecret "SLACK_BOT_TOKEN_GIT_ACTION";
        }
      ];
    };
  };
}
