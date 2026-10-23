{
  dependencies.claude-code.enable = false;

  plugins.claude-code = {
    enable = true;
    settings = {
      window = {
        position = "float";
        hide_numbers = true;
        hide_signcolumn = true;
      };
      keymaps = {
        toggle = {
          normal = "<C-,>";
          terminal = "<C-,>";
          variants = {
            continue = false;
            verbose = false;
          };
        };
      };
    };

  };
}
