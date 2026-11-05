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
      options.desc = "[P]aste before from clipboard";
    }
    {
      key = "<leader>ot";
      action = "<cmd>TermSelect<CR>";
      mode = "n";
      options.desc = "[O]pen [T]erminal list";
    }
    {
      key = "<leader>Ss";
      action = "<cmd>lua MiniSessions.select()<CR>";
      mode = "n";
      options.desc = "[S]elect session";
    }
    {
      key = "<leader>Sw";
      action.__raw = ''
        function()
          local current = vim.fn.fnamemodify(vim.v.this_session, ":t")
          vim.ui.input({ prompt = "Session name: ", default = current }, function(name)
            if name and name ~= "" then MiniSessions.write(name) end
          end)
        end
      '';
      mode = "n";
      options.desc = "[W]rite session";
    }
    {
      key = "<leader>Sd";
      action = "<cmd>lua MiniSessions.select('delete')<CR>";
      mode = "n";
      options.desc = "[D]elete session";
    }
    {
      key = "<C-h>";
      action = "<Cmd>wincmd h<CR>";
      mode = [
        "n"
        "t"
      ];
      options.desc = "Move to left pane";
    }
    {
      key = "<C-j>";
      action = "<Cmd>wincmd j<CR>";
      mode = [
        "n"
        "t"
      ];
      options.desc = "Move to lower pane";
    }
    {
      key = "<C-k>";
      action = "<Cmd>wincmd k<CR>";
      mode = [
        "n"
        "t"
      ];
      options.desc = "Move to upper pane";
    }
    {
      key = "<C-l>";
      action = "<Cmd>wincmd l<CR>";
      mode = [
        "n"
        "t"
      ];
      options.desc = "Move to right pane";
    }
  ];

  # resume terminal mode when moving back into a terminal pane
  autoCmd = [
    {
      event = "WinEnter";
      pattern = "term://*";
      command = "startinsert";
    }
  ];
}
