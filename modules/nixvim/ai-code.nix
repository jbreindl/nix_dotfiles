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
}
