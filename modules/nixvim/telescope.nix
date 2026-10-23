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
      "<leader>s" = {
        action = "lsp_document_symbols";
        options = {
          desc = "Document [S]ymbols";
        };
      };
    };
    settings = {
      prompt_position = "top";
    };

  };
}
