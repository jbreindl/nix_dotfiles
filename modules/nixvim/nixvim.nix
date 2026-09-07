{ ... }:
{
  programs.nixvim = {
    enable = true;
    colorschemes.catppuccin.enable = true;
    defaultEditor = true;
    imports = [
      ./telescope.nix
      ./whichkey.nix
      ./mini.nix
      ./lsp.nix
      ./blink.nix
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
      smarttab = true;
      spelllang = "en_us,de";
      spell = true;
    };
    globals = {
      mapleader = " ";
    };
    diagnostic.settings = {
      virtual_text = true;
    };
    plugins.lualine.enable = true;

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
