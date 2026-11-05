{ pkgs, ... }:
{
  plugins.dap = {
    enable = true;
    signs = {
      dapBreakpoint = {
        text = "●";
        texthl = "DiagnosticError";
      };
      dapBreakpointCondition = {
        text = "◆";
        texthl = "DiagnosticWarn";
      };
      dapStopped = {
        text = "▶";
        texthl = "DiagnosticOk";
        linehl = "Visual";
      };
    };
    # open/close the view with the session
    extensionConfigLua = ''
      local dap, dv = require("dap"), require("dap-view")
      dap.listeners.before.attach["dap-view-config"] = function() dv.open() end
      dap.listeners.before.launch["dap-view-config"] = function() dv.open() end
      dap.listeners.before.event_terminated["dap-view-config"] = function() dv.close() end
      dap.listeners.before.event_exited["dap-view-config"] = function() dv.close() end

      -- dap-python's own .env parser leaves ''${VAR} unexpanded and pre-empts load_dotenv()
      dap.listeners.on_config["python-env"] = function(config)
        if config.type ~= "python" and config.type ~= "debugpy" then
          return config
        end
        config = vim.deepcopy(config)
        config.envFile = config.envFile or "/dev/null"
        config.cwd = config.cwd or vim.fn.getcwd()
        config.env = vim.tbl_extend("keep", config.env or {}, { PWD = config.cwd })
        return config
      end
    '';
  };
  plugins.dap-view.enable = true;
  plugins.dap-virtual-text.enable = true;
  plugins.dap-python = {
    enable = true;
    adapterPythonPath = "uv";
  };

  extraPackages = [ pkgs.uv ];

  plugins.which-key.settings.spec = [
    {
      __unkeyed-1 = "<leader>D";
      group = "[D]ebug";
    }
  ];

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
          key = "<M-c>";
          lua = "require('dap').continue()";
          desc = "Debug: continue / start";
        }
        {
          key = "<M-n>";
          lua = "require('dap').step_over()";
          desc = "Debug: step over";
        }
        {
          key = "<M-i>";
          lua = "require('dap').step_into()";
          desc = "Debug: step into";
        }
        {
          key = "<M-o>";
          lua = "require('dap').step_out()";
          desc = "Debug: step out";
        }
        {
          key = "<leader>b";
          lua = "require('dap').toggle_breakpoint()";
          desc = "Toggle [B]reakpoint";
        }
        {
          key = "<leader>B";
          lua = "require('dap').set_breakpoint(vim.fn.input('Condition: '))";
          desc = "Conditional [B]reakpoint";
        }
        {
          key = "<leader>Dc";
          lua = "require('dap').run_to_cursor()";
          desc = "Run to [C]ursor";
        }
        {
          key = "<leader>Dr";
          lua = "require('dap').restart()";
          desc = "[R]estart";
        }
        {
          key = "<leader>Dq";
          lua = "require('dap').terminate()";
          desc = "[Q]uit session";
        }
        {
          key = "<leader>Dv";
          lua = "require('dap-view').toggle()";
          desc = "Toggle [V]iew";
        }
        {
          key = "<leader>Dt";
          lua = "require('dap-python').test_method()";
          desc = "Debug [T]est method";
        }
        {
          key = "<leader>De";
          lua = "require('dap-view').add_expr()";
          desc = "Watch [E]xpression";
          mode = [
            "n"
            "v"
          ];
        }
      ];
}
