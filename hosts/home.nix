{ config, pkgs, ... }:
{
  home.username = "jbreindl";
  home.homeDirectory = "/home/jbreindl/";
  imports = [
    ../modules/cli.nix
    ../modules/desktop.nix
    ../modules/sway/base.nix
  ];
  targets = {
    # Make home-manager work better on non-NixOS
    genericLinux.enable = true;
    genericLinux.gpu.enable = true;
  };
  home.packages = with pkgs; [
    discord
    steam
  ];
}
