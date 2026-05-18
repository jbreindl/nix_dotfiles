{ config, pkgs, ... }:
{

  programs.wezterm = {
    enable = true;
  };

  home.file = {
    ".config/wezterm/wezterm.lua".source = ./wezterm/wezterm.lua;
    ".config/wezterm/appearance.lua".source = ./wezterm/appearance.lua;
    ".config/wezterm/multiplexing.lua".source = ./wezterm/multiplexing.lua;
    ".config/wezterm/tabline.lua".source = ./wezterm/tabline.lua;
  };

  home.sessionVariables = {
    NIXOS_OZONE_WL = "1"; # For Electron/Chromium-based apps
    MOZ_ENABLE_WAYLAND = "1"; # For Firefox
    QT_QPA_PLATFORM = "wayland"; # For Qt apps
    GDK_BACKEND = "wayland"; # For GTK apps
    SDL_VIDEODRIVER = "wayland"; # For SDL apps
    CLUTTER_BACKEND = "wayland";
  };

  home.packages = with pkgs; [
    (pkgs.symlinkJoin {
      name = "whatsapp-electron";
      paths = [ whatsapp-electron ];
      buildInputs = [ pkgs.makeWrapper ];
      postBuild = ''
        wrapProgram $out/bin/whatsapp-electron \
            --add-flags "--no-sandbox"
      '';
    })
    firefox
    fira-code
    nerd-fonts.fira-code
    networkmanager
    networkmanagerapplet
    blueman
  ];

}
