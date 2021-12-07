{ lib, ...}:
{
  options.random-gif.tag = lib.mkOption {
    type = lib.types.nonEmptyStr;
    description = "random gif search tag";
    default = "celebrate";
    example = "cry";
  };
  options.random-gif.rating = lib.mkOption {
    type = lib.types.nonEmptyStr;
    description = "random gif rating https://developers.giphy.com/docs/optional-settings/#rating";
    default = "pg";
    example = "pg";
  };
  options.random-gif.api-key-env-var = lib.mkOption {
    type = lib.types.nonEmptyStr;
    description = "random gif name of env var with API TOKEN";
    default = "GIPHY_TOKEN";
    example = "GIPHY_TOKEN";
  };
}
