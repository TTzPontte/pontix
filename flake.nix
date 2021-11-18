{
  description = "Dev Environment";

  inputs.dsf.url = "github:cruel-intentions/devshell-files";

  outputs = inputs: inputs.dsf.lib.mkShell [ ./project.nix ];

  nixConfig.substituters = [ "s3://pontte-nix-cache" ]; 
}
