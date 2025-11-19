#!/bin/bash

set -e  # Exit on error (optional but recommended)

BASE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
SOURCE_DIR="$BASE_DIR/hal9000"
DESTINATION="$HOME/.config/conky/hal9000"
STARTUP_DIR="$HOME/.config/autostart"
LAUNCH_SCRIPT="$DESTINATION/launch-hal9000.sh"

echo "🚀 Installing HAL9000 Conky..."

# Handle case where destination already exists
if [[ -d "$DESTINATION" ]]; then
    echo " ⚠️ Directory $DESTINATION already exists."
    echo -n " Do you want to overwrite it? [Y/n] "
    read -r OVERWRITE

    if [[ ! "${OVERWRITE:-Y}" =~ ^[Yy]$ ]]; then
        echo " ⛔ Installation cancelled."
        exit 0
    fi

    echo " 🛠️ Clearing old installation..."
    rm -rf "$DESTINATION"
fi

# Recreate directory cleanly
mkdir -p "$DESTINATION"

# Copy files safely (only if source contains files)
if compgen -G "$SOURCE_DIR/*" > /dev/null; then
    cp -r "$SOURCE_DIR"/* "$DESTINATION"
else
    echo " ⛔ ERROR: No files in source directory: $SOURCE_DIR"
    exit 1
fi

echo " ✅ Successfully installed."

# Ask about startup
echo ""
echo -n "Do you want to launch HAL9000 Conky at startup? [Y/n] "
read -r STARTUP_CONFIRM

if [[ "${STARTUP_CONFIRM:-Y}" =~ ^[Yy]$ ]]; then
    STARTUP_FILE="$STARTUP_DIR/hal9000-conky.desktop"
    if [[ -f "$STARTUP_FILE" ]]; then
        echo " ⚠️ Startup file already exists. Recreating..."
    else
        echo " 🛠️ Creating startup file..."
        mkdir -p "$STARTUP_DIR"
    fi

    cat > "$STARTUP_FILE" <<EOF
[Desktop Entry]
Categories=System;
Exec=cd "$DESTINATION" && conky -c "$DESTINATION/conky.conf"
Name=HAL9000 Conky
Path=$DESTINATION
StartupNotify=true
Terminal=false
Type=Application
EOF

    echo " ✅ Startup file created at: $STARTUP_FILE"
fi

# Ask to launch now
echo ""
echo -n "Do you want to launch it now? [Y/n] "
read -r LAUNCH_NOW_CONFIRM

if [[ "${LAUNCH_NOW_CONFIRM:-Y}" =~ ^[Yy]$ ]]; then
    echo " 🚀 Launching HAL9000 Conky..."
    bash "$LAUNCH_SCRIPT"
    echo " 🤖 HAL9000 is now watching you."
    echo ""
else
    echo ""
    echo "🎉 Done!"
fi

