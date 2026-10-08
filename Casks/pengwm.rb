cask "pengwm" do
  # DEPRECATED — PengWM ships bare binaries now (ADR-0001 in the PengWM
  # repo); this cask's bundle artifacts no longer exist. Install the
  # formula instead:
  #
  #   brew uninstall --cask pengwm
  #   brew install penqguin/tap/pengwm
  #
  # Then re-run PengWM's install.sh once to lay down the LaunchAgent for
  # the new layout.
  version "9999"
  sha256 :no_check

  url "https://github.com/Penqguin/PengWM"
  name "PengWM (deprecated)"
  homepage "https://github.com/Penqguin/PengWM"

  disable! date: "2026-10-07", because: "moved to the penqguin/tap/pengwm formula (bare-binary layout)"
end
