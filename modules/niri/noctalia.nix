{
  config,
  lib,
  pkgs,
  ...
}:

let
  # Stylix's resolved base16 palette, hex strings prefixed with "#".
  c = config.lib.stylix.colors.withHashtag;
  isDark = config.stylix.polarity == "dark";

  # Map the base16 palette onto Noctalia's Material-you colour keys. Noctalia
  # reads scheme files from ~/.config/noctalia/colorschemes/<Name>/<Name>.json
  # (see ColorSchemeService.qml). A flat object (no dark/light nesting) is
  # applied as-is regardless of the darkMode toggle, so one file tracks Stylix.
  stylixScheme = {
    mPrimary = c.base0D; # accent (blue)
    mOnPrimary = c.base00;
    mSecondary = c.base0E; # magenta/purple
    mOnSecondary = c.base00;
    mTertiary = c.base0C; # cyan
    mOnTertiary = c.base00;
    mError = c.base08; # red
    mOnError = c.base00;
    mSurface = c.base00; # background
    mOnSurface = c.base05; # foreground
    mSurfaceVariant = c.base01; # lighter background
    mOnSurfaceVariant = c.base04;
    mOutline = c.base03; # comments / borders
    mShadow = c.base00;
    mHover = c.base0C;
    mOnHover = c.base00;

    terminal = {
      normal = {
        black = c.base00;
        red = c.base08;
        green = c.base0B;
        yellow = c.base0A;
        blue = c.base0D;
        magenta = c.base0E;
        cyan = c.base0C;
        white = c.base05;
      };
      bright = {
        black = c.base03;
        red = c.base08;
        green = c.base0B;
        yellow = c.base0A;
        blue = c.base0D;
        magenta = c.base0E;
        cyan = c.base0C;
        white = c.base07;
      };
      foreground = c.base05;
      background = c.base00;
      selectionFg = c.base00;
      selectionBg = c.base05;
      cursorText = c.base00;
      cursor = c.base05;
    };
  };
in
{
  # The noctalia-shell wrapper bundles quickshell (`qs`) with the right Qt
  # plugin / QML import paths plus its runtime tools (brightnessctl, cliphist,
  # ddcutil, wl-clipboard, wlr-randr, imagemagick, ...). The niri config spawns
  # it at startup.
  home.packages = [ pkgs.noctalia-shell ];

  # Generate a Noctalia colour scheme from the Stylix palette. Read-only symlink
  # is fine — Noctalia only ever reads scheme files.
  xdg.configFile."noctalia/colorschemes/Stylix/Stylix.json".text =
    builtins.toJSON stylixScheme;

  # Point Noctalia at the generated scheme. settings.json is owned/rewritten by
  # Noctalia at runtime, so we only patch the colorSchemes keys (and seed the
  # file if absent) instead of managing it declaratively — that keeps it
  # writable while still wiring the theme to Stylix on every activation.
  home.activation.noctaliaStylix = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    noctaliaCfg="${config.xdg.configHome}/noctalia"
    noctaliaSettings="$noctaliaCfg/settings.json"
    run mkdir -p "$noctaliaCfg"
    [ -f "$noctaliaSettings" ] || echo '{}' > "$noctaliaSettings"
    ${pkgs.jq}/bin/jq \
      '.colorSchemes = ((.colorSchemes // {}) + {"useWallpaperColors": false, "predefinedScheme": "Stylix", "darkMode": ${
        if isDark then "true" else "false"
      }})' \
      "$noctaliaSettings" > "$noctaliaSettings.new" \
      && mv "$noctaliaSettings.new" "$noctaliaSettings"
  '';
}
