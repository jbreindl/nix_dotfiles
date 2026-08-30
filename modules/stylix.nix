{
  pkgs,
  nix-wallpaper,
  config,
  ...
}:
{
  stylix = {
    enable = true;
    autoEnable = false;

    polarity = "light";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-latte.yaml";

    image = config.wallpaper.image;
    fonts = {
      monospace = {
        package = pkgs.nerd-fonts.fira-code;
        name = "FiraCode Nerd Font";
      };
      sizes.terminal = 16;
    };

    opacity.terminal = 1.0;

    # programs
    targets = {
      waybar = {
        enable = true;
      };
      ghostty = {
        enable = true;
      };

      bat.enable = true;
      yazi.enable = true;
      rofi.enable = true;
      fzf.enable = true;
      lazygit.enable = true;
      zellij.enable = true;
      btop.enable = true;
      # zen-browser.enable = true;
      alacritty.enable = true;
      kitty.enable = true;
      sway.enable = true;
      swaync.enable = true;

    };
  };
}
