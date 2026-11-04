{
  dependencies.claude-code.enable = false;
  plugins.claudecode.enable = true;

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
      key = "<leader>as";
      action = "<cmd>ClaudeCodeSend<CR>";
      mode = "v";
      options.desc = "[A]I [S]end selection";
    }
    {
      key = "<leader>ab";
      action = "<cmd>ClaudeCodeAdd %<CR>";
      mode = "n";
      options.desc = "[A]I add [B]uffer";
    }
    {
      key = "<leader>ay";
      action = "<cmd>ClaudeCodeDiffAccept<CR>";
      mode = "n";
      options.desc = "[A]I accept diff ([Y]es)";
    }
    {
      key = "<leader>an";
      action = "<cmd>ClaudeCodeDiffDeny<CR>";
      mode = "n";
      options.desc = "[A]I deny diff ([N]o)";
    }
  ];
}
