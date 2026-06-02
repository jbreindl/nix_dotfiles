{ pkgs, nix-wallpaper, ... }:
let
  wallpaper-pkg = nix-wallpaper.packages.${pkgs.system}.default.override {
    preset = "catppuccin-latte-rainbow";
  };
in
{
  stylix = {
    enable = true;
    # Opt in to targets one at a time rather than letting Stylix theme every
    # app at once — the other modules (ghostty, helix, zellij, …) still set
    # their own themes for now, so auto-enabling would collide with them.
    autoEnable = false;

    polarity = "light";
    image = "${wallpaper-pkg}/share/wallpapers/nixos-wallpaper.png";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-latte.yaml";

    fonts = {
      monospace = {
        package = pkgs.fira-code;
        name = "Fira Code";
      };
      sizes.terminal = 16;
    };

    opacity.terminal = 0.95;
  };
}
