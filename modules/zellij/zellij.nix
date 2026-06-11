{ ... }:
{
  programs.zellij = {
    enable = true;
    settings = {
      theme = "catppuccin-latte";
      default_mode = "locked";
      show_startup_tips = false;
    };
    extraConfig = builtins.readFile ./keybinds.kdl;
  };
  xdg.configFile."zellij/layouts/dev.kdl".source = ./dev.kdl;

}
