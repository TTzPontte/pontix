rec {
  ghEnv = parentKey: key: "\${{ ${parentKey}.${key} }}";
  ghSecret = key: ghEnv "secrets" key;
  toCron = { minute ? "*", hour ? "*", day ? "*", month ? "*", weekDay ? "*" }:
    with builtins; "${toString minute} ${toString hour} ${toString day} ${toString month} ${toString weekDay}";
  toSchedule = cronDef: [{ cron = toCron cronDef; }];
  installNix = {
    uses = "cachix/install-nix-action@v13";
    "with" = {
      "install_url" = "https://nixos-nix-install-tests.cachix.org/serve/i6laym9jw3wg9mw6ncyrk6gjx4l34vvx/install";
      "install_options" = "--tarball-url-prefix https://nixos-nix-install-tests.cachix.org/serve";
      "extra_nix_config" = "experimental-features = nix-command flakes";
    };
  };
  mkJob = args@{ name, steps, ... }: args // {
    "${name}" = {
      runs-on = "ubuntu-latest";
      steps = [ installNix ] ++ steps;
    };
  };
  makes = args: "nix-shell run 'm ${args}'";
  makesIt = args: makes ". ${args}";
}
