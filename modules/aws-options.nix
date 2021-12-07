{ lib, config, ...}:
{
  options.pontix.aws = lib.mkOption {
    description = "Ponttix AWS Options";
    default = {};
    type = lib.types.submodule {
      options.ci-cd = lib.mkOption {
        description = "Pontte AWS Options for CI-CD";
        default = {};
        type = lib.types.submodule {
          options.secrets = lib.mkOption {
            description = "Pontte AWS Options for CI-CD secret names";
            default = {};
            type = lib.types.submodule {
              options.id = lib.mkOption {
                description = "name of secret with AWS_ACCESS_KEY_ID";
                default = "AWS_ACCESS_KEY_ID";
              };
              options.key = lib.mkOption {
                description = "name of secret with AWS_SECRET_ACCESS_KEY";
                default = "AWS_SECRET_ACCESS_KEY";
              };
              options.region = lib.mkOption {
                description = "name of secret with AWS_DEFAULT_REGION";
                default = "AWS_DEFAULT_REGION";
              };
            };
          };
          options.envs = let cfg = config.pontix.aws.ci-cd; in lib.mkOption {
            description = "Pontte AWS Options for CI-CD defauult env";
            type = lib.types.attrsOf lib.types.str;
            default.AWS_ACCESS_KEY_ID = ''''${{ secrets.${cfg.secrets.id} }}'';
            default.AWS_SECRET_ACCESS_KEY = ''''${{ secrets.${cfg.secrets.key} }}'';
            default.AWS_DEFAULT_REGION = ''''${{ secrets.${cfg.secrets.region} }}'';
          };
        };
      };
    };
  };
}
