{
  config.files.cmds.convco = true;
  config.files.cmds.git-extras = true;
  # to our .gitignore
  config.files.gitignore.template."Global/Archives" = true;
  config.files.gitignore.template."Global/Backup" = true;
  config.files.gitignore.template."Global/Diff" = true;
  # now we can use 'feat' command as alias to convco
  config.files.alias.feat = ''convco commit --feat $@'';
  config.files.alias.fix = ''convco commit --fix $@'';
  config.files.alias.chore = ''convco commit --chore $@'';
  config.files.alias.tag-it = ''
    STAGE=$(get-stage)
    SUFFIX="-$STAGE"
    if echo "$STAGE" | grep -q '^prod$'; then
      SUFFIX=""
    fi
    echo Old tag v$(convco version)$SUFFIX
    echo New tag v$(convco version --bump)$SUFFIX
    git tag v$(convco version --bump)$SUFFIX
    git push --tag
  '';
  config.files.alias.get-stage = ''
    REF=${"$"}{GITHUB_REF:-"refs/heads/$(git rev-parse --abbrev-ref HEAD)"}
    STAGE="dev"
    if echo "$REF" | grep -q '^refs/heads/master$'; then
      STAGE="prod"
    fi
    if echo "$REF" | grep -q '^refs/heads/staging$'; then
      STAGE="staging"
    fi
    echo $STAGE
  '';
}
