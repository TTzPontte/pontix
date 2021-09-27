args:
let
  makeScript = args.makeScript;
  inputs = args.inputs;
  toFile = file:
    let
      out = { name, to, ... }: "${to}${name}";
      content = import file args;
    in
    content // {
      create = ''
        mkdir -p ${content.to}
        cp --no-preserve all ${content.file} ${out content}
      '';
    };
  files = builtins.map toFile [ ./README.nix ./gh-actions.nix ];
  creates = builtins.map (f: f.create) files;
in
makeScript {
  name = "dynamicFiles";
  entrypoint = builtins.concatStringsSep "\n" creates;
}
