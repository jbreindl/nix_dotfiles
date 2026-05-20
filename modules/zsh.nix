{config, pkgs, ...}:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    oh-my-zsh= {
      enable=true;
      plugins = [
        "git"
        "tmux"
        "history-substring-search"
        "per-directory-history"
      ];
      theme = "jispwoso";
      extraConfig = ''

      DISABLE_AUTO_TITLE="true"
      ENABLE_CORRECTION="true"
      DISABLE_UNTRACKED_FILES_DIRTY="true"
      '';
    };
  };
}
