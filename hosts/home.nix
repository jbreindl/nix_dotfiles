{ pkgs, inputs, ... }:
{
  home.username = "jbr";
  home.homeDirectory = "/home/jbr/";
  imports = [
    ../modules/cli.nix
    ../modules/desktop.nix
    ../modules/sway/sway.nix
    ../modules/waybar/waybar.nix
    ../modules/waybar/sway.nix
    ../modules/nixvim/nixvim.nix
  ];

  home.packages = with pkgs; [
    discord
    steam
    arduino-cli
    signal-desktop
  ];
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Julius Breindl";
        email = "juliusb1616@gmail.com";
      };
      init.defaultBranch = "main";
    };
  };
  programs.alacritty.enable = true;

}
