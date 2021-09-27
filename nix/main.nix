{ makeScript
, ...
}:
makeScript {
  name = "Main";
  entrypoint = ''
    echo "hello bro"
  '';
}
