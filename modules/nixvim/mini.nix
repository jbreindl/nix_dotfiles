{
  plugins.mini = {
    enable = true;
    mockDevIcons = true;
    modules = {
      icons = { };
      ai.custom_textobjects.__raw = ''
        {
          F = require("mini.ai").gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }),
          c = require("mini.ai").gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }),
        }
      '';
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
      bracketed = { };
      surround = { };
      sessions = { };
    };
  };

}
