{ lib, config, ...}:
{
  imports = [ ./randomGifOptions.nix ];
  files.cmds.curl = true;
  files.cmds.gnused = true;
  files.alias.random-gif-tag = ''
    ACTOR=${"$"}{GITHUB_ACTOR:-"$(git log -1 --pretty=format:'%an')"}
    TAG="${config.random-gif.tag}"
    if echo "$TAG" | grep -q 'celebrate'; then
      if echo "$ACTOR" | grep -iq 'Guezin'; then
        TAG="guitar"
      fi
      if echo "$ACTOR" | grep -iq 'hugo'; then
        TAG="YEAH"
      fi
      if echo "$ACTOR" | grep -iq 'mafloro|maeli'; then
        TAG="SNOOPY"
      fi
      if echo "$ACTOR" | grep -iq 'matheus'; then
        TAG="science"
      fi
      if echo "$ACTOR" | grep -iq 'Mr-i-me|lucas'; then
        TAG="troppy"
      fi
      if echo "$ACTOR" | grep -iq 'oliver'; then
        TAG="pizza"
      fi
      if echo "$ACTOR" | grep -iq 'peter|pedro'; then
        TAG="dino"
      fi
      if echo "$ACTOR" | grep -iq 'raperina|reafel'; then
        TAG="rapper"
      fi
      if echo "$ACTOR" | grep -iq 'washington'; then
        TAG="wash"
      fi
      if echo "$ACTOR" | grep -iq 'william'; then
        TAG="bill"
      fi
    fi
    echo $TAG
  '';
  files.alias.random-gif = ''
    GIF_RATING="${config.random-gif.rating}"
    GIF_TAG=random-git-tag
    GIPHY_TOKEN="${"$"}${config.random-gif.api-key-env-var}"
    curl -s https://api.giphy.com/v1/gifs/random?api_key=$GIPHY_TOKEN&tag=$GIF_TAG&rating=$GIF_RATING
  '';
}
