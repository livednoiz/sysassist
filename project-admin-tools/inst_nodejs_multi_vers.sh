#!/bin/bash

NODE_VERSIONS=("16.20.2" "18.20.8" "20.19.2" "22.16.0")
INSTALL_DIR="/opt/plesk/node"

mkdir -p "$INSTALL_DIR"

for VERSION in "${NODE_VERSIONS[@]}"; do
  MAJOR=$(echo $VERSION | cut -d. -f1)
  DEST="$INSTALL_DIR/$MAJOR"

  echo "🔧 Installiere Node.js $VERSION in $DEST ..."
  mkdir -p "$DEST"
  cd "$DEST"

  URL="https://nodejs.org/dist/v$VERSION/node-v$VERSION-linux-x64.tar.xz"
  curl -O "$URL"
  tar -xf "node-v$VERSION-linux-x64.tar.xz" --strip-components=1
  rm "node-v$VERSION-linux-x64.tar.xz"

  ln -sf "$DEST/bin/node" "/usr/local/bin/node$MAJOR"
  ln -sf "$DEST/bin/npm" "/usr/local/bin/npm$MAJOR"
  echo "✅ Node.js $VERSION installiert."
done