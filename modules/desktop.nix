{
  config,
  pkgs,
  inputs,
  ...
}:
{

  home.sessionVariables = {
    NIXOS_OZONE_WL = "1"; # For Electron/Chromium-based apps
    MOZ_ENABLE_WAYLAND = "1"; # For Firefox
    QT_QPA_PLATFORM = "wayland"; # For Qt apps
    GDK_BACKEND = "wayland"; # For GTK apps
    SDL_VIDEODRIVER = "wayland"; # For SDL apps
    CLUTTER_BACKEND = "wayland";
  };

  home.packages = with pkgs; [
    firefox
    nerd-fonts.fira-code
    networkmanager
    networkmanagerapplet
    blueman
    ghostty
    pulseaudio
    pavucontrol
  ];
  programs.rofi.enable = true;

  imports = [
    ./ghostty.nix
    ./stylix.nix
    ./zen-browser.nix
  ];

}
