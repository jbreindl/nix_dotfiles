{ config, pkgs, ... }:
{
  home.username = "jbr";
  home.homeDirectory = "/home/jbr/";
  imports = [
    ../modules/cli.nix
    ../modules/desktop.nix
    ../modules/niri/base.nix
    # ../modules/hyprland/base.nix
  ];
  home.packages = with pkgs; [
    discord
    steam
  ];
  programs.git = {
    enable = true;
    settings.user = {
      name = "Julius Breindl";
      email = "juliusb1616@gmail.com";
    };
  };
}
