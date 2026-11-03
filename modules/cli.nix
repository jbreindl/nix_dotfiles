{
  config,
  pkgs,
  inputs,
  ...
}:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    ripgrep
    git
    zsh
    uv
    direnv
    nixd
    nil
    nixfmt
    zellij
    bat
    yazi
    rustup
    tree
    just
    glow
    claude-code
    claude-agent-acp
    arduino-language-server
    clang-tools
    gh
    unzip
    typst
    grafana-loki
    awscli2
  ];

  programs.btop.enable = true;
  programs.bat.enable = true;
  programs.fzf.enable = true;
  programs.yazi.enable = true;
  programs.claude-code.enable = true;

  # local module definitions
  imports = [
    ./zsh.nix
    ./helix.nix
    ./tmux.nix
    ./zellij/zellij.nix
    ./lazygit.nix
    ./nix.nix
    ./nixvim/nixvim.nix
    inputs.nixvim.homeModules.nixvim
  ];

  home.sessionVariables = {
    LANG = "en_US.UTF-8";
    LANGUAGE = "en_US.UTF-8";
    LC_ALL = "en_US.UTF-8";
  };

  programs.home-manager.enable = true;
}
