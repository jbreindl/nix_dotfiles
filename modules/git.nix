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
}
