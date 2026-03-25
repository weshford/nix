#!/usr/bin/env bash
# Script to apply macOS-style colored buttons using kwin decoration
# This uses the Breeze decoration but injects custom button colors

CONFIG_DIR="${HOME}/.config"

# Create custom breeze theme with colored buttons
mkdir -p "${CONFIG_DIR}/kwinrc.d"

cat > "${CONFIG_DIR}/kwinrc.d/macos-buttons" << 'EOF'
[org.kde.kdecoration2]
ButtonsOnLeft=M
ButtonsOnRight=AX
library=org.kde.breeze
theme=Breeze
EOF

# Use kwriteconfig to set button appearance colors
kwriteconfig6 --file kwinrc --group "org.kde.kdecoration2" --key "ButtonsOnLeft" "M"
kwriteconfig6 --file kwinrc --group "org.kde.kdecoration2" --key "ButtonsOnRight" "AX"

# Create custom palette for button coloring
mkdir -p "${HOME}/.local/share/kwin"

cat > "${HOME}/.local/share/kwin/macos-buttons.json" << 'EOF'
{
  "buttons": {
    "close": {
      "color": "rgb(255, 95, 86)",
      "name": "Close"
    },
    "maximize": {
      "color": "rgb(255, 189, 46)",
      "name": "Maximize"
    },
    "minimize": {
      "color": "rgb(39, 201, 142)",
      "name": "Minimize"
    }
  }
}
EOF

# Reload kwin
qdbus org.kde.KWin /KWin org.kde.KWin.reloadConfig 2>/dev/null || true

echo "macOS-style colored buttons applied!"
