{ ... }:
{
  home.username = "jbr";
  home.homeDirectory = "/home/jbr/";
  imports = [
    ../modules/cli.nix
    ../modules/desktop.nix
    ../modules/niri/base.nix
  ];

  programs.git = {
    enable = true;
    settings.user = {
      name = "Julius Breindl";
      email = "juliusb1616@gmail.com";
    };
  };
}
