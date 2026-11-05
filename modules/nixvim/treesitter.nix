{
  plugins = {
    treesitter = {
      enable = true;
      highlight.enable = true;
      indent.enable = true;
      folding.enable = false;
    };
    # only provides the queries, selection is done by mini.ai
    treesitter-textobjects = {
      enable = true;
    };
  };
}
