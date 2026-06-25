cask "chatcut" do
  version "0.1.0"
  sha256 "dfc57ea674f1af5415cbd51865599574390688a80850df1ee563034ce1526418"

  url "https://github.com/ChatCut-Inc/chatcut-desktop/releases/download/v#{version}/ChatCut-#{version}-arm64.dmg"
  name "ChatCut"
  desc "AI-powered video editor"
  homepage "https://chatcut.io"

  auto_updates true
  depends_on arch: :arm64
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
