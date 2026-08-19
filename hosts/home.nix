{ pkgs, inputs, ... }:
{
  home.username = "jbr";
  home.homeDirectory = "/home/jbr/";
  imports = [
    ../modules/cli.nix
    ../modules/desktop.nix
    ../modules/kde.nix
  ];

  home.packages = with pkgs; [
    discord
    steam
    kdePackages.krohnkite
    klassy
  ];
  programs.git = {
    enable = true;
    settings.user = {
      name = "Julius Breindl";
      email = "juliusb1616@gmail.com";
    };
  };

}
