{ ... }:

{
  programs.ghostty = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      theme = "Catppuccin Latte";
      font-family = "Fira Code";
      font-size = 16;
      window-theme = "light";
      window-decoration = "none";
      background-opacity = 0.95;
    };
  };
}
