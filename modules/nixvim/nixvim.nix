{ pkgs, ... }:
let
  codelldb = pkgs.vscode-extensions.vadimcn.vscode-lldb;
  extPath = "${codelldb}/share/vscode/extensions/vadimcn.vscode-lldb";
  libExt = if pkgs.stdenv.hostPlatform.isDarwin then "dylib" else "so";

in
{
  programs.nixvim = {
    enable = true;
    nixpkgs.config.allowUnfree = true;
    colorschemes.catppuccin = {
      enable = true;
      settings.flavour = "frappe";
    };
    defaultEditor = true;
    imports = [
      ./keys.nix
      ./whichkey.nix
      ./mini.nix
      ./lsp.nix
      ./blink.nix
      ./ai-code.nix
      ./neorg.nix
      ./treesitter.nix
      ./no-neck-pain.nix
      ./snacks.nix
      ./dap.nix
    ];
    opts = {
      relativenumber = true;
      cursorline = true;
      scrolloff = 10;
      signcolumn = "yes";
      expandtab = true;
      tabstop = 4;
      softtabstop = 4;
      shiftwidth = 4;
      autoread = true;
      spelllang = "en_us,de";
      spell = true;
      wrap = false;
      linebreak = false;
      conceallevel = 2;
      concealcursor = "nc";
      swapfile = false;
    };
    globals = {
      mapleader = " ";
    };
    files."ftplugin/nix.lua".opts = {
      tabstop = 2;
      softtabstop = 2;
      shiftwidth = 2;
    };
    diagnostic.settings = {
      virtual_text = false;
      float = {
        border = "rounded";
        source = true;
      };
    };
    # plugins with minimal config
    plugins = {
      lualine.enable = true;
      direnv.enable = true;
      typst-vim.enable = true;
      typst-preview.enable = true;
      nvim-autopairs.enable = true;
      image = {
        enable = true;
        settings.integrations.typst.enabled = false;
      };
      rainbow.enable = true;
      wrapping.enable = true;
      noice.enable = true;
      toggleterm = {
        enable = true;
        settings = {
          direction = "float";
          open_mapping = "[[<C-\\>]]";
          terminal_mappings = true;
          autochdir = true;
          float_opts.border = "rounded";
        };
      };
      rustaceanvim = {
        enable = true;
        # settings.dap.adapter = {
        #   type = "executable";
        #   command = "${pkgs.lldb}/bin/lldb-dap";
        #   name = "lldb";
        # };
        settings = {
          dap.adapter.__raw = ''
            require("rustaceanvim.config").get_codelldb_adapter(
              "${extPath}/adapter/codelldb",
              "${extPath}/lldb/lib/liblldb.${libExt}"
            )
          '';
        };
      };
    };

    autoCmd = [
      {
        event = "TextYankPost";
        callback.__raw = ''
          	function()
          	    vim.highlight.on_yank()
          	end
          	'';

      }
    ];
    extraConfigLua = ''
      require("dap").listeners.on_config["lldb-dap-console"] = function(config)
        if config.type ~= "lldb" then return config end
        local c = vim.deepcopy(config)
        c.console = "internalConsole"
        return c
      end
    '';
  };
}
