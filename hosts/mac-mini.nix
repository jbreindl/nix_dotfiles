{ pkgs, inputs, ... }:
{

  imports = [
    ../modules/cli.nix
    ../modules/ghostty.nix
    ../modules/stylix.nix
    ../modules/aerospace.nix
    ../modules/ollama.nix
    ../modules/opencode.nix
  ];

  home.packages = with pkgs; [
    signal-desktop
    ghostty-bin
  ];
  programs.git = {
    enable = true;
    settings.user = {
      name = "Julius Breindl";
      email = "juliusb1616@gmail.com";
    };
    ignores = [
      "*~"
      "*.swp"
      ".DS_Store"
    ];
  };

}
