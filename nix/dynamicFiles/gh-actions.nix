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
      name = "build";
    };
  };
}
