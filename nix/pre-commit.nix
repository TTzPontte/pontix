{ inputs ? import ./inputs.nix
, src ? ../.
}:
inputs.pre-commit-hooks.run {
  src = ../.;
  hooks = {
    checks = {
      enable = true;
      entry = "echo 'commit lint';m . /lintGitCommitMsg;m . /check";
    };
  };
}
