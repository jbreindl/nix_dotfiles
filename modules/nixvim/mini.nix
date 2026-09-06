{
  plugins.mini = {
    enable = true;
    mockDevIcons = true;
    modules = {
      icons = { };
      ai = { };
      comment = {
        mappings = {
          comment_line = "<leader>c";
          comment_visual = "<leader>c";
        };
      };
      move = {
        mappings = {
          left = "<M-h>";
          right = "<M-l>";
          down = "<M-j>";
          up = "<M-k>";

        };
      };
      surround = { };
    };
  };
}
