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
      virtual_text = true;
    };
    # plugins with minimal config
    plugins = {
      lualine.enable = true;
      typst-vim.enable = true;
      typst-preview.enable = true;
      nvim-autopairs.enable = true;
      # noice.enable = true;
      image = {
        enable = true;
        settings.integrations.typst.enabled = false;
      };
      rainbow.enable = true;
      wrapping.enable = true;
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

  };
}
