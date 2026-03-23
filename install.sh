#!/bin/bash

set -e

URL="https://github.com/danfordd/multiserver-rustdesk-install/releases/download/release/rustdesk-linux-flutter.tar.gz"
TMP_DIR="/tmp/rustdesk-install"
INSTALL_DIR="/opt/rustdesk"
DESKTOP_FILE="/usr/share/applications/rustdesk.desktop"

echo "[*] Установка RustDesk в $INSTALL_DIR"

if [[ $EUID -ne 0 ]]; then
    echo "Запусти с рут правами"
    exit 1
fi

rm -rf "$TMP_DIR"
mkdir -p "$TMP_DIR"

curl -L --progress-bar "$URL" -o "$TMP_DIR/rustdesk.tar.gz"

tar -xzf "$TMP_DIR/rustdesk.tar.gz" -C "$TMP_DIR"

RUSTDESK_BIN=$(find "$TMP_DIR" -type f -name "rustdesk" | head -n 1)
LIB_DIR=$(find "$TMP_DIR" -type d -name "lib" | head -n 1)
DATA_DIR=$(find "$TMP_DIR" -type d -name "data" | head -n 1)

if [[ -z "$RUSTDESK_BIN" ]]; then
    echo "бинарник rustdesk не найден"
    exit 1
fi

if [[ -z "$LIB_DIR" ]]; then
    echo "папка lib не найдена"
    exit 1
fi

if [[ -z "$DATA_DIR" ]]; then
    echo "папка data не найдена"
    exit 1
fi

rm -rf "$INSTALL_DIR"
mkdir -p "$INSTALL_DIR"

cp "$RUSTDESK_BIN" "$INSTALL_DIR/rustdesk"
cp -r "$LIB_DIR" "$INSTALL_DIR/"
cp -r "$DATA_DIR" "$INSTALL_DIR/"

rm -rf "$TMP_DIR"

chmod +x "$INSTALL_DIR/rustdesk"
chmod -R 755 "$INSTALL_DIR/lib"
chmod -R 755 "$INSTALL_DIR/data"

ln -sf "$INSTALL_DIR/rustdesk" /usr/local/bin/rustdesk

bash -c "cat > $DESKTOP_FILE" <<EOF
[Desktop Entry]
Version=1.0
Type=Application
Name=RustDesk
Exec=$INSTALL_DIR/rustdesk
Icon=$INSTALL_DIR/rustdesk
Terminal=false
Categories=Network;Utility;
EOF

chmod 644 "$DESKTOP_FILE"

echo "Готово."