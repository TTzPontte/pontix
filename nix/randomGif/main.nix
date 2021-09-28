{ makeScript
, inputs ? import ../inputs.nix
, outputs
, ...
}:
let
  D = "$";
in
makeScript {
  name = "random-gif";
  searchPaths = {
    bin = [
      inputs.nixpkgs.curl
      inputs.nixpkgs.gnused
    ];
  };
  entrypoint = ''
    GIF_RATING="${D}{GIF_RATING=pg-13}"
    GIF_TAG="${D}{GIF_TAG=glad}"
    curl -s 'https://api.giphy.com/v1/gifs/random?api_key='$GIPHY_TOKEN'&tag='$GIF_TAG'&rating='$GIF_RATING
  '';
}
