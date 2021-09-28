{ makeScript
, inputs ? import ../inputs.nix
, outputs
, ...
}:
let
  D = "$";
in
makeScript {
  name = "notify-slack";
  searchPaths = {
    bin = [
      inputs.nixpkgs.curl
      inputs.nixpkgs.jq
      inputs.nixpkgs.gnugrep
      outputs."/randomGif"
    ];
  };
  entrypoint = ''
    GIFED_BRANCH=${D}{GIFED_BRANCH=master}
    PROD_GIF=`echo $GITHUB_REF | grep -q -E "$GIFED_BRANCH" && random-gif|tail -n 1|jq -r .data.image_url`
     
    SHIP=":ship: $(echo $GITHUB_REF|cut -f3 -d/)"
    PACKAGE=":package: [$(echo $GITHUB_REPOSITORY|cut -f2 -d/)]"
    ACTOR=":bust_in_silhouette: $GITHUB_ACTOR"
    TEXT="$SHIP
    $PACKAGE
    $ACTOR
    $PROD_GIF"
    CHANNEL="$SLACK_BOT_CHANNEL"
    DATA=`echo '{}'|jq --arg C "$CHANNEL" --arg T "$TEXT" '.|.channel=$C|.text=$T'`
    curl -s -X POST \
      -H "Content-type: application/json" \
      -H "Authorization: Bearer $SLACK_BOT_TOKEN_GIT_ACTION" \
      -d "$DATA" https://slack.com/api/chat.postMessage
  '';
}
