class Pengwm < Formula
  desc "Tiling window manager for macOS (Accessibility & Core Graphics, no SIP changes)"
  homepage "https://github.com/Penqguin/PengWM"
  version "0.6.0"
  license "MIT"

  # Bare-binary layout (ADR-0001 in Pengqguin/PengWM): two executables,
  # launched via the `pengwm` CLI and a launchd LaunchAgent. Per-arch URLs
  # interpolate #{version} so the automated bump workflow only has to
  # touch the version and the two sha256 lines below.
  on_macos do
    on_arm do
      url "https://github.com/Penqguin/PengWM/releases/download/v#{version}/pengwm-v#{version}-aarch64-apple-darwin.tar.gz"
      sha256 "207e7c0b9962d89e3b0a92e1f5d78aa58dd9bcc75ab7cae12cc570e0f636848a"
    end
    on_intel do
      url "https://github.com/Penqguin/PengWM/releases/download/v#{version}/pengwm-v#{version}-x86_64-apple-darwin.tar.gz"
      sha256 "d8dd2b6e5a6ae463d4d93cbd1f4d8cd6d1b8d91f3ba370581dd429f2471eb8f6"
    end
  end

  def install
    bin.install "pengwm", "pengwm-menubar"
  end

  def caveats
    <<~EOS
      PengWM needs Accessibility permissions:
        System Settings → Privacy & Security → Accessibility → add #{HOMEBREW_PREFIX}/bin/pengwm

      Releases are ad-hoc signed (no Apple certificate), so every
      `brew upgrade` of pengwm costs one Accessibility re-grant.
      See docs/adr/0001-bare-binary-distribution.md in the PengWM repo.

      Homebrew does not manage the launchd agent. To start the daemon at
      login, either run PengWM's installer once (it lays down the agent and
      a separate ~/.pengwm/bin copy — fine to have alongside brew) or write
      ~/Library/LaunchAgents/com.pengwm.daemon.plist with ProgramArguments
      pointing at #{HOMEBREW_PREFIX}/bin/pengwm, then:
        launchctl bootstrap gui/$(id -u) ~/Library/LaunchAgents/com.pengwm.daemon.plist

      Also enable: System Settings → Desktop & Dock → "Displays have
      separate Spaces".
    EOS
  end
end
