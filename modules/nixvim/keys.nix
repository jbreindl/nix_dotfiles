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
      key = "<leader>ot";
      action = "<cmd>TermSelect<CR>";
      mode = "n";
      options.desc = "[O]pen [T]erminal list";
    }
    {
      key = "<leader>os";
      action = "<cmd>lua MiniSessions.select()<CR>";
      mode = "n";
      options.desc = "[O]pen [S]ession";
    }
    {
      key = "<leader>ow";
      action.__raw = ''
        function()
          local current = vim.fn.fnamemodify(vim.v.this_session, ":t")
          vim.ui.input({ prompt = "Session name: ", default = current }, function(name)
            if name and name ~= "" then MiniSessions.write(name) end
          end)
        end
      '';
      mode = "n";
      options.desc = "[O]pen: [W]rite session";
    }
    {
      key = "<leader>od";
      action = "<cmd>lua MiniSessions.select('delete')<CR>";
      mode = "n";
      options.desc = "[O]pen: [D]elete session";
    }
    {
      key = "<C-h>";
      action = "<C-w>h";
      mode = "n";
      options.desc = "Move to left pane";
    }
    {
      key = "<C-j>";
      action = "<C-w>j";
      mode = "n";
      options.desc = "Move to lower pane";
    }
    {
      key = "<C-k>";
      action = "<C-w>k";
      mode = "n";
      options.desc = "Move to upper pane";
    }
    {
      key = "<C-l>";
      action = "<C-w>l";
      mode = "n";
      options.desc = "Move to right pane";
    }
  ];

  # Only map <Esc> in toggleterm buffers so TUIs like LazyGit keep their own <Esc>
  autoCmd = [
    {
      event = "TermOpen";
      pattern = "term://*toggleterm#*";
      callback.__raw = ''
        function(args)
          vim.keymap.set("t", "<Esc><Esc>", [[<C-\><C-n>]], { buffer = args.buf, desc = "Leave terminal mode" })
        end
      '';
    }
  ];
}
