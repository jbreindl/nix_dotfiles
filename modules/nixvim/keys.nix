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
    {
      key = "<leader>ot";
      action = "<cmd>ToggleTerm<CR>";
      mode = "n";
      options.desc = "[O]pen [T]erminal";
    }
    {
      key = "<leader>os";
      action = "<cmd>AutoSession search<CR>";
      mode = "n";
      options.desc = "[O]pen [S]ession";
    }
  ];

  # Only map <Esc> in toggleterm buffers so TUIs like LazyGit keep their own <Esc>
  autoCmd = [
    {
      event = "TermOpen";
      pattern = "term://*toggleterm#*";
      callback.__raw = ''
        function(args)
          vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { buffer = args.buf, desc = "Leave terminal mode" })
        end
      '';
    }
  ];
}
