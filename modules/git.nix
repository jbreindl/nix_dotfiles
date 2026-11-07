{ ... }:
{
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Julius Breindl";
      };
      init.defaultBranch = "main";
      pull.rebase = true;
    };
  };
  xdg.configFile."git/ignore".source = ./gitignore;
}
