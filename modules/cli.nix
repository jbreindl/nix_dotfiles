{
  pkgs,
  inputs,
  ...
}:

{
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.11"; # Please read the comment before changing.

  home.packages = with pkgs; [
    ripgrep
    git
    zsh
    uv
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
    ./lazygit.nix
    ./nix.nix
    ./profile.nix
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
