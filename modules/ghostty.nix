{ ... }:

{
  programs.ghostty = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      # theme = "iTerm2 Solarized Light";
      theme = "Nord";
      font-family = "Fira Code";
      font-size = 16;
      window-theme = "light";
      window-decoration = "none";
      background-opacity = 0.95;
    };
  };
}
