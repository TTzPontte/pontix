{ lib, config, ...}:
{
  options.random-gif.tag = lib.mkOption {
    type = lib.types.nonEmptyStr;
    description = "random gif search tag";
    default = "happy";
    example = "cry";
  };
  options.random-gif.rating = lib.mkOption {
    type = lib.types.nonEmptyStr;
    description = "random gif rating https://developers.giphy.com/docs/optional-settings/#rating";
    default = "pg-13";
    example = "pg";
  };
  options.random-gif.api-key-env-var = lib.mkOption {
    type = lib.types.nonEmptyStr;
    description = "random gif name of env var with API TOKEN";
    default = "GIPHY_TOKEN";
    example = "GIPHY_TOKEN";
  };
  config.files.cmds.curl = true;
  config.files.cmds.gnused = true;
  config.files.alias.random-gif = ''
    GIF_RATING="${config.random-gif.rating}"
    GIF_TAG="${config.random-gif.tag}"
    GIPHY_TOKEN="${"$"}${config.random-gif.api-key-env-var}"
    curl -s https://api.giphy.com/v1/gifs/random?api_key=$GIPHY_TOKEN&tag=$GIF_TAG&rating=$GIF_RATING
  '';
}
