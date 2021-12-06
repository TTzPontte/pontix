{ 
  # enable .gitignore creation
  config.files.gitignore.enable = true;
  # to our .gitignore
  config.files.gitignore.template."Python" = true;

  config.files.cmds.python38 = true;
  config.files.cmds.pipenv = true;
  # look at https://search.nixos.org for more tools
}
