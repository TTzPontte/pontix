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
    m . /lintGitCommitMsg
    m . /dynamicFiles
    m . /formatMarkdown
    m . /formatNix
  '';
}
