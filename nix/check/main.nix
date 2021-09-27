{ makeScript
, inputs ? import ../inputs.nix
, ...
}:
makeScript {
  name = "checks";
  searchPaths = {
    bin = [ inputs.makes ];
  };
  entrypoint = ''
    m . /formatNix
    m . /formatMarkdown
  '';
}
