{ makeScript
, inputs
, ...
}:
let
  defaultOut = to: file: ext: "${to}${file}.${ext}";
  toFile = { ext, comment ? f: "", to ? "./", out ? defaultOut }: file: rec {
    inherit ext file to comment;
    content = builtins.toFile "${file}.${ext}" ''${comment file}${import (./. + "/${file}.nix")}'';
    hook = ''
      mkdir -p ${to}
      cp --no-preserve all ${content} ${out to file ext}
      ${inputs.nixpkgs.git}/bin/git add -f ${out to file ext}
    '';
  };
  mdComment = f: "<!-- generated by nix/${f}.nix -->\n";
  README = toFile { ext = "md"; comment = mdComment; } "README";
  yamlComment = f: "# generated by nix/${f}.nix -->\n";
  gh-actions = toFile
    {
      ext = "yaml";
      comment = yamlComment;
      to = "./.github/workflows/";
    } "gh-actions";
in
makeScript {
  name = "bootstraping";
  entrypoint = ''
    ${README.hook}
    ${gh-actions.hook}
  '';
}
