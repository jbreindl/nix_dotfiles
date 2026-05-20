{ config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    oh-my-zsh = {
      enable = true;
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

    envExtra = ''
      if [ -e /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh ]; then
        . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
      fi
    '';
  };
  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;

  };
}
