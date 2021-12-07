{ lib, config, ...}:
{
  options.notify-slack.gifted-branch = lib.mkOption {
    type = lib.types.nonEmptyStr;
    description = "branch with random gif";
    default = "master";
    example = "main";
  };
  options.notify-slack.api-key-env-var = lib.mkOption {
    type = lib.types.nonEmptyStr;
    description = "Env var name of bot API TOKEN";
    default = "SLACK_BOT_TOKEN";
    example = "SLACK_BOT_TOKEN";
  };
}
