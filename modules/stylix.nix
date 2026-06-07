{ pkgs, nix-wallpaper, ... }:
let
  wallpaper-pkg = nix-wallpaper.packages.${pkgs.system}.default.override {
    preset = "catppuccin-latte-rainbow";
  };
in
{
  stylix = {
    enable = true;
    autoEnable = false;

    polarity = "light";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-latte.yaml";

    fonts = {
      monospace = {
        package = pkgs.nerd-font.fira-code;
        name = "FiraCode Nerd Font";
      };
      sizes.terminal = 16;
    };

    opacity.terminal = 0.95;

    # programs
    targets = {
      waybar = {
        enable = true;
      };
      ghostty = {
        enable = true;
      };

    };
  };
}
