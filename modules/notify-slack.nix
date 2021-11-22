{ lib, config, ...}:
{
  imports = [ ./randomGif.nix ];
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
  config.files.cmds.curl = true;
  config.files.cmds.jq = true;
  config.files.cmds.git-extras = true;
  config.files.alias.notify-slack = ''
    SLACK_BOT_TOKEN="${"$"}${config.notify-slack.api-key-env-var}"
    DATA=`echo '{}'|jq --arg C "$1" --arg T "$2" '.|.channel=$C|.text=$T'`
    curl -s -X POST \
      -H "Content-type: application/json" \
      -H "Authorization: Bearer $SLACK_BOT_TOKEN" \
      -d "$DATA" https://slack.com/api/chat.postMessage
  '';
  config.files.alias.notify-slack-gh-build = ''
    GIFED_BRANCH="${config.notify-slack.gifted-branch}"
    PROD_GIF=`echo $GITHUB_REF | grep -q -E "$GIFED_BRANCH" && random-gif|tail -n 1|jq -r .data.url`
    SHIP=":ship: $(echo $GITHUB_REF|cut -f3 -d/)"
    PACKAGE=":package: $(echo $GITHUB_REPOSITORY|cut -f2 -d/) $(convco version --bump)"
    ACTOR=":bust_in_silhouette: $GITHUB_ACTOR"
    CHANGELOG=$(convco changelog|sed -n /\.\.\.HEAD/,/\.\.\.$(convco version)/p|head -n -1|tail -n +2)
    OUR_CHANGELOG=`echo $GITHUB_REF | grep -q -E "$GIFED_BRANCH" && echo "$CHANGELOG"`
    notify-slack $SLACK_BOT_CHANNEL "
      $SHIP
      $PACKAGE
      $ACTOR
      $OUR_CHANGELOG
      $PROD_GIF
    "
  '';
  config.gh-actions.notify-slack.build = "notify-slack-gh-build";
  config.gh-actions.notify-slack.env.build.GIPHY_TOKEN = ''${"$"}{{ secrets.GIPHY_TOKEN }}'';
  config.gh-actions.notify-slack.env.build.SLACK_BOT_CHANNEL = ''${"$"}{{ secrets.SLACK_BOT_CHANNEL }}'';
  config.gh-actions.notify-slack.env.build.SLACK_BOT_TOKEN = ''${"$"}{{ secrets.SLACK_BOT_TOKEN_GIT_ACTION }}'';
}
