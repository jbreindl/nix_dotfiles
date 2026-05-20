{...}:{
  home.username = "jbr";
  home.homeDirectory = "/home/jbr";
  imports = [
    ../modules/cli.nix
    ../modules/desktop.nix
    ../modules/sway/sway-work.nix
    ];
  targets = {
    # Make home-manager work better on non-NixOS
    genericLinux.enable = true;
    genericLinux.gpu.enable = true;
  };
}
