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
      ./auto-session.nix
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
      swapfile = false;
    };
    globals = {
      mapleader = " ";
    };
    diagnostic.settings = {
      virtual_text = true;
    };
    # plugins with minimal config
    plugins = {
      lualine.enable = true;
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
      wrapping.enable = true;
      toggleterm.enable = true;
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
