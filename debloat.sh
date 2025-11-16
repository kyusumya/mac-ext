
apps=("GarageBand" "iMovie" "Chess")

paths=(
  "/Applications/APP.app"
  "~/Library/Application Support/APP"
  "~/Library/Preferences/com.apple.APP.plist"
  "~/Library/Caches/com.apple.APP"
  "~/Library/Logs/APP"
  "~/Library/LaunchAgents/com.apple.APP*.plist"
  "/Library/Application Support/APP"
  "/Library/Preferences/com.apple.APP.plist"
  "/Library/LaunchAgents/com.apple.APP*.plist"
  "/Library/LaunchDaemons/com.apple.APP*.plist"
)

for app in "${apps[@]}"; do
    echo "Deleting $app..."
    for p in "${paths[@]}"; do
        target="${p//APP/$app}"
        rm -rf $target
    done
done
