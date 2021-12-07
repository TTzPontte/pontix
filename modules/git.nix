{
  files.cmds.convco = true;
  files.cmds.git-extras = true;
  # to our .gitignore
  files.gitignore.template."Global/Archives" = true;
  files.gitignore.template."Global/Backup" = true;
  files.gitignore.template."Global/Diff" = true;
  # now we can use 'feat' command as alias to convco
  files.alias.feat = ''convco commit --feat $@'';
  files.alias.fix = ''convco commit --fix $@'';
  files.alias.chore = ''convco commit --chore $@'';
  files.alias.tag-it = ''
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
  files.alias.get-stage = ''
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
