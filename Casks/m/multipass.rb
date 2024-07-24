cask "multipass" do
  version "1.14.0"
  sha256 "28cb0fe42d0570ca8f6df677a5ea95e01c61a380de8428ec0c33fc1c18a30b8f"

  on_arm do
    postflight do
      File.symlink("/Library/Application Support/com.canonical.multipass/Resources/completions/bash/multipass",
                   "#{HOMEBREW_PREFIX}/etc/bash_completion.d/multipass")
    end
  end

  url "https://github.com/canonical/multipass/releases/download/v#{version}/multipass-#{version}+mac-Darwin.pkg"
  name "Multipass"
  desc "Orchestrates virtual Ubuntu instances"
  homepage "https://github.com/canonical/multipass/"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: ">= :mojave"

  pkg "multipass-#{version}+mac-Darwin.pkg"

  uninstall launchctl: "com.canonical.multipassd",
            pkgutil:   "com.canonical.multipass.*",
            delete:    [
              "#{HOMEBREW_PREFIX}/etc/bash_completion.d/multipass",
              "/Applications/Multipass.app",
              "/Library/Application Support/com.canonical.multipass",
              "/Library/Logs/Multipass",
              "/usr/local/bin/multipass",
              "/usr/local/etc/bash_completion.d/multipass",
            ]

  zap trash: [
    "~/Library/Application Support/com.canonical.multipassGui",
    "~/Library/Application Support/multipass",
    "~/Library/Application Support/multipass-gui",
    "~/Library/LaunchAgents/com.canonical.multipass.gui.autostart.plist",
    "~/Library/Preferences/multipass",
    "~/Library/Saved Application State/com.canonical.multipassGui.savedState",
  ]
end
