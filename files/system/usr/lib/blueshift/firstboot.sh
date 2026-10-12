#!/usr/bin/env bash
# Apply BlueShift per-user branding once, at first login.
marker="$HOME/.config/.blueshift-firstboot-done"
[ -f "$marker" ] && exit 0
mkdir -p "$HOME/.config"
touch "$marker"

KW=kwriteconfig6
command -v kwriteconfig6 >/dev/null 2>&1 || KW=kwriteconfig5

# our logo as panel/menu icons + our system sounds
"$KW" --file kdeglobals --group Icons --key Theme Blueshift 2>/dev/null
"$KW" --file kdeglobals --group Sounds --key Theme Blueshift 2>/dev/null

# nature wallpaper on the desktop
QDBUS=qdbus6
command -v qdbus6 >/dev/null 2>&1 || QDBUS=qdbus
"$QDBUS" org.kde.plasmashell /PlasmaShell org.kde.PlasmaShell.evaluateScript '
  var d = desktops()[0];
  d.wallpaperPlugin = "org.kde.image";
  d.currentConfigGroup = ["Wallpaper", "org.kde.image", "General"];
  d.writeConfig("Image", "file:///usr/share/wallpapers/BlueshiftMountain/contents/images/1792x1024.png");
  d.currentConfigGroup = [];
' 2>/dev/null

exit 0
