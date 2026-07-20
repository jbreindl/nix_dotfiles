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

  # ── graphical-session.target ──────────────────────────────────────────
  # niri is launched as the bare `niri --session` binary (from the shell
  # login), NOT via its systemd unit `niri.service`. That unit is what would
  # normally pull up `graphical-session.target` (it has BindsTo/Before it), so
  # with the bare binary the target never activates.
  #
  # xdg-desktop-portal-gnome.service has `Requisite=graphical-session.target`:
  # while the target is dead it fails to start with a 'dependency' error, and
  # every D-Bus activation attempt for it blocks on the ~25s (later 120s)
  # activation timeout. That breaks BOTH ScreenCast/Screenshot (routed to gnome
  # below → screen sharing dead) AND makes the main portal take ~50s to finish
  # starting, during which GTK apps like ghostty stall waiting on it.
  #
  # Fix: define our own session target that we ARE allowed to start manually and
  # that pulls `graphical-session.target` up as a dependency (BindsTo implies
  # Requires; a dependency-driven start bypasses the target's RefuseManualStart).
  # niri's startup command (config.kdl) starts this, mirroring what niri.service
  # would have done. Same shape home-manager's sway module uses for
  # sway-session.target.
  systemd.user.targets.niri-session = {
    Unit = {
      Description = "niri compositor session";
      Documentation = [ "man:systemd.special(7)" ];
      BindsTo = [ "graphical-session.target" ];
      Wants = [ "graphical-session-pre.target" "xdg-desktop-autostart.target" ];
      After = [ "graphical-session-pre.target" ];
      Before = [ "xdg-desktop-autostart.target" ];
    };
  };

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
