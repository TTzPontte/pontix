{ inputs ? import ./inputs.nix
, src ? ../.
}:
inputs.pre-commit-hooks.run {
  src = ../.;
  hooks = {
    checks = {
      enable = true;
      entry = ''
        env
        echo "PRE COMMIT HOOK"
        m . /lintGitCommitMsg
        m ./check
      '';
    };
  };
}
