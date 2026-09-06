{ ... }:
{
  plugins.telescope = {
    enable = true;
    keymaps = {
      "<leader>f" = {
        action = "find_files";
        options = {
          desc = "Telescope Files";
        };
      };
      "<leader>/" = {
        action = "live_grep";
        options = {
          desc = "Live Grep";
        };
      };
      "<leader>d" = {
        action = "diagnostics";
        options = {
          desc = "Diagnostics for buffer";
        };
      };
    };
    settings = {
      prompt_position = "top";
    };

  };
}
