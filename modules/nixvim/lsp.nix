{
  plugins.lsp = {
    enable = true;
    inlayHints = false;
    autoLoad = true;
    keymaps = {
      lspBuf = {
        "<leader>k" = "hover";
        "gd" = "definition";
        "<leader>a" = "code_action";
      };
    };
    servers = {
      nixd = {
        enable = true;
      };
      ruff.enable = true;
      ty.enable = true;
      rust_analyzer = {
        enable = true;
        installCargo = false;
        installRustc = false;
      };
    };
  };
  plugins.conform-nvim = {
    enable = true;
    settings = {
      format_on_save = {
        timeout_ms = 500;
        lsp_format = "fallback";
      };
      formatters_by_ft = {
        python = [
          "ruff_fix"
          "ruff_format"
          "ruff_organize_imports"
        ];
      };
    };
  };
  #  this isn't working
  plugins.lsp.servers.nixd.settings.options.home_manager.expr =
    ''(builtins.getFlake (toString ./.)).homeConfigurations."home".options'';
}
