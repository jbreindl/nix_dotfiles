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

  xdg.configFile."niri/config.kdl".source = ./config.kdl;

  # xdg-desktop-portal backend routing for the niri session.
  # niri ships no *-portals.conf, so without this the portal picks a bad
  # default. niri is a Smithay (NOT wlroots) compositor and does not implement
  # zwlr_screencopy_manager_v1, so xdg-desktop-portal-wlr cannot screencast
  # under it (it crash-loops with "Compositor doesn't support
  # zwlr_screencopy_manager_v1"). niri exposes screencasting via the Mutter
  # ScreenCast D-Bus API, which xdg-desktop-portal-gnome serves — so Screenshot
  # and ScreenCast go to gnome. Everything else (FileChooser, Settings, ...)
  # goes to gtk — otherwise GTK apps like ghostty stall on the portal at startup.
  # Requires the xdg-desktop-portal-gnome backend to be installed (apt on this
  # non-NixOS host: `sudo apt install xdg-desktop-portal-gnome`).
  xdg.configFile."xdg-desktop-portal/portals.conf".text = ''
    [preferred]
    default=gtk
    org.freedesktop.impl.portal.Screenshot=gnome
    org.freedesktop.impl.portal.ScreenCast=gnome
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
    wl-clipboard
    brightnessctl
    rofi # Mod+D launcher in the KDL config
  ];
}
