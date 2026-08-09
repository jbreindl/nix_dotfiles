{ pkgs, ... }:
{
  home.username = "jbr";
  home.homeDirectory = "/home/jbr";
  imports = [
    ../modules/cli.nix
    ../modules/desktop.nix
    ../modules/niri/base.nix
  ];

  targets = {
    # Make home-manager work better on non-NixOS
    genericLinux.enable = true;
    genericLinux.gpu.enable = true;
  };

  home.packages = with pkgs; [
    thunderbird
    teams-for-linux
  ];

  programs.git = {
    enable = true;
    settings.user = {
      name = "Julius Breindl";
      email = "jbr@condat.de";
    };
  };
}
