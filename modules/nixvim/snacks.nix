{ ... }:
{
  plugins.snacks = {
    enable = true;
    settings = {
      dashboard = {
        enabled = true;
        # snacks only detects session plugins through lazy.nvim
        preset.keys = [
          {
            icon = " ";
            key = "f";
            desc = "Find File";
            action = ":lua Snacks.dashboard.pick('files')";
          }
          {
            icon = " ";
            key = "n";
            desc = "New File";
            action = ":ene | startinsert";
          }
          {
            icon = " ";
            key = "g";
            desc = "Find Text";
            action = ":lua Snacks.dashboard.pick('live_grep')";
          }
          {
            icon = " ";
            key = "r";
            desc = "Recent Files";
            action = ":lua Snacks.dashboard.pick('oldfiles')";
          }
          {
            icon = " ";
            key = "s";
            desc = "Sessions";
            action = ":lua MiniSessions.select()";
          }
          {
            icon = " ";
            key = "q";
            desc = "Quit";
            action = ":qa";
          }
        ];
        # default "startup" section requires lazy.nvim
        sections = [
          { section = "header"; }
          {
            section = "keys";
            gap = 1;
            padding = 1;
          }
        ];
      };
      picker.enabled = true;
      lazygit.enabled = true;
      notifier.enabled = true;
      indent.enabled = true;
      scope.enabled = true;
      bigfile.enabled = true;
      quickfile.enabled = true;
      words.enabled = true;
    };
  };

  keymaps =
    map
      (
        {
          key,
          lua,
          desc,
          mode ? "n",
        }:
        {
          inherit key mode;
          action.__raw = "function() ${lua} end";
          options.desc = desc;
        }
      )
      [
        {
          key = "<leader>f";
          lua = "Snacks.picker.files()";
          desc = "Find [F]iles";
        }
        {
          key = "<leader>/";
          lua = "Snacks.picker.grep()";
          desc = "Live Grep";
        }
        {
          key = "<leader>d";
          lua = "Snacks.picker.diagnostics_buffer()";
          desc = "[D]iagnostics for buffer";
        }
        {
          key = "<leader>s";
          lua = "Snacks.picker.lsp_symbols()";
          desc = "Document [S]ymbols";
        }
        {
          key = "<leader>og";
          lua = "Snacks.lazygit()";
          desc = "[O]pen Lazy[G]it";
        }
        {
          key = "]]";
          lua = "Snacks.words.jump(vim.v.count1)";
          desc = "Next reference";
          mode = [
            "n"
            "t"
          ];
        }
        {
          key = "[[";
          lua = "Snacks.words.jump(-vim.v.count1)";
          desc = "Prev reference";
          mode = [
            "n"
            "t"
          ];
        }
      ];
}
