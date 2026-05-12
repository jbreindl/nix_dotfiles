{ config, pkgs, ... }:
{
  home.username = "jbreindl";
  home.homeDirectory = "/home/jbreindl/";
  imports = [
    ../modules/cli.nix
    ../modules/desktop.nix
  ];

  home.packages = with pkgs; [
    discord
    steam
  ];
}
