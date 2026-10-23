{ ... }:

{
  programs.ghostty = {
    enable = true;
    enableZshIntegration = true;

    settings = {
      confirm-close-surface = false;
      keybind = [
        "clear"
        "ctrl+shift+c=copy_to_clipboard"
        "ctrl+shift+v=paste_from_clipboard"
      ];
    };
  };
}
