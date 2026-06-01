{ ... }:
{
  programs.zellij = {
    enable = true;
    settings = {
      theme = "nord";
      default_mode = "locked";
      show_startup_tips = false;
      # TODO set up default layouts
    };
    # TODO: write in some keybinds once I have some ideas
    # extraConfig = ''
    #   set up different modes
    # '';
  };
}
