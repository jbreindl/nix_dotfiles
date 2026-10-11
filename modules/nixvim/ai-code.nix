{
  plugins.codecompanion = {
    enable = true;
    settings = {
      interactions = {
        chat.adapter = "claude_code";
        inline.adapter = "claude_code";
        cmd.adapter = "claude_code";
        background.adapter = "claude_code";
      };
    };
  };
  plugins.claude-code = {
    enable = true;
    settings = {
      window = {
        position = "float";
        hide_numbers = true;
        hide_signcolumn = true;
      };
      dependencies.claude-code.enable = false;
    };

  };
}
