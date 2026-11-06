{ pkgs, ... }:
{
  home.username = "jbr";
  home.homeDirectory = "/home/jbr";
  imports = [
    ../modules/cli.nix
    ../modules/desktop.nix
    ../modules/kde.nix
    # ../modules/sway/sway.nix
    # ../modules/sway/sway-work.nix
    # ../modules/waybar/waybar.nix
    # ../modules/waybar/sway.nix

  ];

  services.swaync.enable = false;
  home.packages = with pkgs; [
    glab
  ];

  targets = {
    # Make home-manager work better on non-NixOS
    genericLinux.enable = true;
    genericLinux.gpu.enable = true;
  };

  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Julius Breindl";
        email = "jbr@condat.de";
      };
      init.defaultBranch = "main";
      pull.rebase = true;
    };
    includes =
      map
        (dir: {
          condition = "gitdir:${dir}";
          contents.user.email = "juliusb1616@gmail.com";
        })
        [
          "~/dev/personal/**"
          "~/.config/**"
        ];
  };
  xdg.configFile."git/ignore".source = ./work-gitignore;
}
