{
  config.files.alias.compress = "tar -I 'gzip -1' -cf $2 $1";
  config.files.alias.decompress = "tar -xzf $1 -C $2";
  config.files.alias.cache-it = ''
    LOCK_FILE=$1
    SOURCE_DIR=$2
    TMP_DIR="."$(mktemp)"/"
    mkdir -p $TMP_DIR
    DEST_TAR="$(sha256sum $LOCK_FILE|cut -d' ' -f1).tar.gz"
    aws s3 ls s3://pontte-nix-cache/$DEST_TAR | wc -l && exit 0
    compress $SOURCE_DIR $TMP_DIR$DEST_TAR
    sync $TMP_DIR s3://pontte-nix-cache
    rm -rf tmp
  '';
  config.files.alias.use-cache = ''
    LOCK_FILE=$1
    DEST_DIR=$2
    TAR_FILE="$(sha256sum $LOCK_FILE|cut -d' ' -f1).tar.gz"
    aws s3 cp s3://pontte-nix-cache/$TAR_FILE $TAR_FILE &>/dev/null || true
    decompress $TAR_FILE $DEST_DIR &>/dev/null || true
  '';
}
