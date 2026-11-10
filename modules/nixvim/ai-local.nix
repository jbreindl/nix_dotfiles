let
  adapter = {
    name = "ollama";
    model = "qwen3-coder:30b";
  };
in
{
  plugins.codecompanion = {
    enable = true;
    settings.interactions = {
      chat.adapter = adapter;
      inline.adapter = adapter;
      cmd.adapter = adapter;
      background.adapter = adapter;
    };
  };

  plugins.which-key.settings.spec = [
    {
      __unkeyed-1 = "<leader>C";
      group = "[C]ode Companion";
    }
  ];

  keymaps = [
    {
      key = "<C-,>";
      action = "<cmd>CodeCompanionChat Toggle<CR>";
      mode = [
        "n"
        "t"
      ];
      options.desc = "Toggle CodeCompanion chat";
    }
    {
      key = "<leader>Cs";
      action = ":CodeCompanionChat Add<CR>";
      mode = "v";
      options.desc = "[S]end selection";
    }
    {
      key = "<leader>Ci";
      action = ":CodeCompanion ";
      mode = [
        "n"
        "v"
      ];
      options.desc = "[I]nline prompt";
    }
    {
      key = "<leader>Ca";
      action = "<cmd>CodeCompanionActions<CR>";
      mode = [
        "n"
        "v"
      ];
      options.desc = "[A]ctions";
    }
  ];
}
