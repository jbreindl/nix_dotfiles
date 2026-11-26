{ ... }:
{
  programs.herdr = {
    enable = true;
    settings = {
      onboarding = false;
      theme = {
        name = "catppuccin-latte";
        auto_switch = false;
      };
      keys.prefix = "ctrl+space";
    };
  };
}
