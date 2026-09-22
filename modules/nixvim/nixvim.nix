{ ... }:
{
  programs.nixvim = {
    enable = true;
    colorschemes.catppuccin = {
      enable = true;
      settings.flavour = "latte";
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
      conceallevel = 2;
      concealcursor = "nc";
    };
    globals = {
      mapleader = " ";
    };
    diagnostic.settings = {
      virtual_text = true;
    };
    plugins.lualine.enable = true;
    plugins.typst-vim.enable = true;
    plugins.notify.enable = true;
    plugins.no-neck-pain.enable = true;

    autoCmd = [
      {
        event = "TextYankPost";
        callback.__raw = ''
          	function()
          	    vim.highlight.on_yank()
          	end
          	'';

      }
      {
        event = "FileType";
        pattern = [
          "text"
          "markdown"
          "typst"
          "norg"
        ];
        command = "setlocal textwidth=100 formatoptions+=tacnq wrap linebreak";
      }
    ];

  };
}
