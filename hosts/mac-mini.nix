{ pkgs, inputs, ... }:
{

  imports = [
    ../modules/cli.nix
    ../modules/ghostty.nix
    ../modules/stylix.nix
    ../modules/aerospace.nix
  ];

  home.packages = with pkgs; [
    signal-desktop
    ghostty-bin
  ];

}
