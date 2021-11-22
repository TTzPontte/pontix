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
    echo Old tag v$(convco version)
    echo New tag v$(convco version --bump)
    git tag v$(convco version --bump)
    git push --tag
  '';
}
