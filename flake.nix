{
  description = "Dev Environment";

  inputs.dsf.url = "github:cruel-intentions/devshell-files";
  inputs.gha.url = "github:cruel-intentions/gh-actions";

  outputs = inputs: 
  let 
    shell = inputs.dsf.lib.mkShell [
      "${inputs.gha}/gh-actions.nix"
      ./project.nix
    ];
    tpls.defaultTemplate.path = ./templates/default;
    tpls.defaultTemplate.description = ''
      nix flake new -t git+ssh://git@github.com/pontte/pontix.git project-name
    '';
    tpls.templates.python.path = ./templates/python;
    tpls.templates.python.description = ''
      nix flake new -t git+ssh://git@github.com/pontte/pontix.git#python project-name
    '';
  in shell // tpls;
}
