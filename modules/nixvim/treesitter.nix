{
  plugins = {
    treesitter = {
      enable = true;
      highlight.enable = true;
      indent.enable = true;
      folding.enable = false;
    };
    treesitter-textobjects = {
      enable = true;
    };
  };

  # nixvim forwards textobjects settings to treesitter's setup, which the
  # refactored plugin ignores, so configure it directly
  extraConfigLua = ''
    require("nvim-treesitter-textobjects").setup({ select = { lookahead = true } })
  '';

  keymaps =
    map
      (
        { key, query, desc }:
        {
          inherit key;
          mode = [
            "x"
            "o"
          ];
          action.__raw = ''
            function()
              require("nvim-treesitter-textobjects.select").select_textobject("${query}", "textobjects")
            end
          '';
          options.desc = desc;
        }
      )
      [
        {
          key = "af";
          query = "@function.outer";
          desc = "[A]round [F]unction";
        }
        {
          key = "if";
          query = "@function.inner";
          desc = "[I]nner [F]unction";
        }
        {
          key = "ac";
          query = "@class.outer";
          desc = "[A]round [C]lass";
        }
        {
          key = "ic";
          query = "@class.inner";
          desc = "[I]nner [C]lass";
        }
      ];

}
