{...}:{
  home.username = "jbr";
  home.homeDirectory = "/home/jbr";
  imports = [
        ../modules/desktop.nix
        ../modules/cli.nix
    ];
}
