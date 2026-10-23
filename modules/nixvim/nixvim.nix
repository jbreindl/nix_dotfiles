{ ... }:
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
      ./telescope.nix
      ./whichkey.nix
      ./mini.nix
      ./lsp.nix
      ./blink.nix
      ./ai-code.nix
      ./neorg.nix
      ./treesitter.nix
      ./no-neck-pain.nix
    ];
    opts = {
      relativenumber = true;
      cursorline = true;
      scrolloff = 10;
      signcolumn = "yes";
      softtabstop = 4;
      shiftwidth = 4;
      smartindent = true;
      autoindent = true;
      autoread = true;
      smarttab = true;
      spelllang = "en_us,de";
      spell = true;
      wrap = false;
      linebreak = false;
      conceallevel = 2;
      concealcursor = "nc";
    };
    globals = {
      mapleader = " ";
    };
    diagnostic.settings = {
      virtual_text = true;
    };
    # plugins with minimal config
    plugins = {
      lualine = {
        enable = true;
        settings.sections.lualine_x = [
          {
            __raw = ''
              function()
                return vim.wo.wrap and "WRAP" or ""
              end
            '';
            color.fg = "#f9e2af";
          }
          "encoding"
          "fileformat"
          "filetype"
        ];
      };
      typst-vim.enable = true;
      typst-preview.enable = true;
      notify.enable = true;
      lazygit.enable = true;
      nvim-autopairs.enable = true;
      noice.enable = true;
      image = {
        enable = true;
        settings.integrations.typst.enabled = false;
      };
      rainbow.enable = true;
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

    userCommands.ProseWrap = {
      desc = "Toggle prose-style wrapping (textwidth, formatoptions, wrap, linebreak)";
      command.__raw = ''
        function()
          if vim.opt_local.wrap:get() then
            vim.opt_local.textwidth = 0
            vim.opt_local.formatoptions:remove("tacnq")
            vim.opt_local.wrap = false
            vim.opt_local.linebreak = false
          else
            vim.opt_local.textwidth = 100
            vim.opt_local.formatoptions:append("tacnq")
            vim.opt_local.wrap = true
            vim.opt_local.linebreak = true
          end
        end
      '';
    };

    keymaps = [
      {
        key = "<leader>tw";
        action = "<cmd>ProseWrap<cr>";
        mode = "n";
        options.desc = "Toggle prose wrap";
      }
    ];
  };
}
