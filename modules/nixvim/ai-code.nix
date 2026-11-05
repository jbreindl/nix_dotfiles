{
  dependencies.claude-code.enable = false;
  plugins.claudecode.enable = true;

  plugins.which-key.settings.spec = [
    {
      __unkeyed-1 = "<leader>C";
      group = "[C]laude";
    }
  ];

  keymaps = [
    {
      key = "<C-,>";
      action = "<cmd>ClaudeCode<CR>";
      mode = [
        "n"
        "t"
      ];
      options.desc = "Toggle Claude Code";
    }
    {
      key = "<leader>Cs";
      action = "<cmd>ClaudeCodeSend<CR>";
      mode = "v";
      options.desc = "[S]end selection";
    }
    {
      key = "<leader>Cb";
      action = "<cmd>ClaudeCodeAdd %<CR>";
      mode = "n";
      options.desc = "Add [B]uffer";
    }
    {
      key = "<leader>Cy";
      action = "<cmd>ClaudeCodeDiffAccept<CR>";
      mode = "n";
      options.desc = "Accept diff ([Y]es)";
    }
    {
      key = "<leader>Cn";
      action = "<cmd>ClaudeCodeDiffDeny<CR>";
      mode = "n";
      options.desc = "Deny diff ([N]o)";
    }
  ];
}
