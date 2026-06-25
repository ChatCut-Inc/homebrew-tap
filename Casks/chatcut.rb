cask "chatcut" do
  arch arm: "arm64", intel: "x64"

  version "0.1.0"
  sha256 arm:   "0000000000000000000000000000000000000000000000000000000000000000",
         intel: "0000000000000000000000000000000000000000000000000000000000000000"

  url "https://github.com/ChatCut-Inc/chatcut-desktop/releases/download/v#{version}/ChatCut-#{version}-#{arch}.dmg"
  name "ChatCut"
  desc "AI-powered video editor"
  homepage "https://chatcut.io"

  auto_updates true
  depends_on macos: ">= :ventura"

  app "ChatCut.app"

  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/ChatCut.app"]
  end

  zap trash: [
    "~/Library/Application Support/ChatCut",
    "~/Library/Caches/io.chatcut.desktop",
    "~/Library/Caches/io.chatcut.desktop.ShipIt",
    "~/Library/Logs/ChatCut",
    "~/Library/Preferences/io.chatcut.desktop.plist",
    "~/Library/Saved Application State/io.chatcut.desktop.savedState",
  ]

  caveats <<~EOS
    This build is ad-hoc signed (not Apple notarized).
    The cask strips the macOS quarantine attribute on install so Gatekeeper
    allows the app to open. A signed + notarized build is on the roadmap.
  EOS
end
