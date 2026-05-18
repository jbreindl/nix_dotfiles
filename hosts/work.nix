{...}:{
  home.username = "jbr";
  home.homeDirectory = "/home/jbr";
  imports = [
        ../modules/desktop.nix
        ../modules/cli.nix
        ../modules/sway/base.nix
        ../modules/sway/sway-work.nix
        ../modules/sway/waybar.nix
    ];
  targets = {
    # Make home-manager work better on non-NixOS
    genericLinux.enable = true;
    genericLinux.gpu.enable = true;
  };
}
