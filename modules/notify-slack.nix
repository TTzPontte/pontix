{ lib, config, ...}:
{
  imports = [
    ./randomGif.nix
    ./notify-slack-options.nix
  ];

  files.cmds.curl = true;
  files.cmds.jq = true;
  files.cmds.git-extras = true;
  files.alias.notify-slack = ''
    SLACK_BOT_TOKEN="${"$"}${config.notify-slack.api-key-env-var}"
    DATA=`echo '{}'|jq --arg C "$1" --arg T "$2" '.|.channel=$C|.text=$T'`
    curl -s -X POST \
      -H "Content-type: application/json" \
      -H "Authorization: Bearer $SLACK_BOT_TOKEN" \
      -d "$DATA" https://slack.com/api/chat.postMessage
  '';
  files.alias.notify-slack-gh-build = ''
    GIFED_BRANCH="${config.notify-slack.gifted-branch}"
    PROD_GIF=`(echo $GITHUB_REF | grep -q -E "$GIFED_BRANCH" && random-gif|tail -n 1|jq -r .data.url|| echo "")`
    SHIP=":ship: $(echo $GITHUB_REF|cut -f3 -d/)"
    PACKAGE=":package: $(echo $GITHUB_REPOSITORY|cut -f2 -d/) $(convco version --bump)"
    ACTOR=":bust_in_silhouette: $GITHUB_ACTOR"
    CHANGELOG=$(convco changelog|sed -n /\.\.\.HEAD/,/\.\.\.$(convco version)/p|head -n -1|tail -n +2)
    OUR_CHANGELOG=`(echo $GITHUB_REF | grep -q -E "$GIFED_BRANCH" && echo "$CHANGELOG") || echo ""`
    notify-slack $SLACK_BOT_CHANNEL "
      $PACKAGE
      $SHIP
      $ACTOR
      $OUR_CHANGELOG
      $PROD_GIF
    "
  '';
  gh-actions.notify-slack.build = "notify-slack-gh-build";
  gh-actions.notify-slack.env.build.GIPHY_TOKEN = ''${"$"}{{ secrets.GIPHY_TOKEN }}'';
  gh-actions.notify-slack.env.build.SLACK_BOT_CHANNEL = ''${"$"}{{ secrets.SLACK_BOT_CHANNEL }}'';
  gh-actions.notify-slack.env.build.SLACK_BOT_TOKEN = ''${"$"}{{ secrets.SLACK_BOT_TOKEN_GIT_ACTION }}'';
}
