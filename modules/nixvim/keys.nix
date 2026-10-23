{
  keymaps = [
    {
      key = "<leader>y";
      action = "\"+y";
      mode = [
        "n"
        "v"
      ];
      options.desc = "[Y]ank to clipboard";
    }
    {
      key = "<leader>p";
      action = "\"+p";
      mode = [
        "n"
        "v"
      ];
      options.desc = "[P]aste after from clipboard";
    }
    {
      key = "<leader>P";
      action = "\"+P";
      mode = [
        "n"
        "v"
      ];
      options.desc = "[P]aste after from clipboard";
    }
    {
      key = "<leader>og";
      action = ":LazyGit<CR>";
      mode = [
        "n"
        "v"
      ];
      options.desc = "[O]pen Lazy[G]it";
    }
  ];
}
