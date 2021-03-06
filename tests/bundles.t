Add multiple bundles.

  $ echo "$PLUGIN_DIR\n$PLUGIN_DIR2" | antigen-bundles
  Cloning into '.+?'\.\.\. (re)
  done.
  Cloning into '.+?'\.\.\. (re)
  done.

Check if they are both applied.

  $ hehe
  hehe
  $ hehe2
  hehe2

Clean it all up.

  $ export _ANTIGEN_BUNDLE_RECORD=""
  $ antigen-cleanup --force &> /dev/null

Specify with indentation.

  $ echo "  $PLUGIN_DIR\n  $PLUGIN_DIR2" | antigen-bundles
  Cloning into '.+?'\.\.\. (re)
  done.
  Cloning into '.+?'\.\.\. (re)
  done.

Again, check if they are both applied.

  $ hehe
  hehe
  $ hehe2
  hehe2
