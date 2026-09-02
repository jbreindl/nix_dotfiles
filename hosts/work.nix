{ pkgs, ... }:
{
  home.username = "jbr";
  home.homeDirectory = "/home/jbr";
  imports = [
    ../modules/cli.nix
    ../modules/desktop.nix
    ../modules/sway/sway.nix
    ../modules/sway/sway-work.nix
    ../modules/waybar/waybar.nix
    ../modules/waybar/sway.nix

  ];

  targets = {
    # Make home-manager work better on non-NixOS
    genericLinux.enable = true;
    genericLinux.gpu.enable = true;
  };
  home.packages = with pkgs; [
    glab
  ];

  programs.git = {
    enable = true;
    settings.user = {
      name = "Julius Breindl";
      email = "jbr@condat.de";
    };
  };
  wallpaper.image = ../modules/wallpapers/house.jpg;
}
