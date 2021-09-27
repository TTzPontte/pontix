{ makeScript
, inputs ? import ../inputs.nix
, outputs
, ...
}:
makeScript {
  name = "checks";
  searchPaths = {
    bin = [
      inputs.makes
      outputs."/dynamicFiles"
      outputs."/formatNix"
    ];
  };
  entrypoint = ''
    dynamicFiles
    format-nix
  '';
}
