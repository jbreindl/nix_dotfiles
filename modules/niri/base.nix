{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./noctalia.nix
  ];

  # Use the hand-written KDL config verbatim. niri live-reloads it on save.
  # We install the niri package and drop the config in place rather than
  # generating it from Nix, so `modules/niri/config.kdl` stays the source of truth.
  xdg.configFile."niri/config.kdl".source = ./config.kdl;

  # xdg-desktop-portal backend routing for the niri (wlroots) session.
  # niri ships no *-portals.conf, so without this the portal picks a bad
  # default. wlr only implements Screenshot/ScreenCast; everything else
  # (FileChooser, Settings/appearance, ...) must go to gtk — otherwise GTK
  # apps like ghostty stall on the portal at startup.
  xdg.configFile."xdg-desktop-portal/portals.conf".text = ''
    [preferred]
    default=gtk
    org.freedesktop.impl.portal.Screenshot=wlr
    org.freedesktop.impl.portal.ScreenCast=wlr
  '';

  # ── Packages needed at runtime ────────────────────────────────────────
  # NOTE: swaylock must be installed via the system package manager on non-NixOS
  # (PAM issue — the Nix swaylock has no matching /etc/pam.d entry). Kept here
  # anyway for NixOS/complete setups; noctalia also ships its own lock screen.
  home.packages = with pkgs; [
    niri
    xwayland-satellite # run X11 apps under niri
    swaybg # wallpaper (config: spawn-at-startup swaybg ...)
    swayidle # idle handling (config: swayidle -w timeout ...)
    swaylock # screen lock (see PAM note above)
    wl-clipboard
    brightnessctl
    rofi # Mod+D launcher in the KDL config
  ];
}
