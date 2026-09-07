{ pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    prefix = "C-Space";
    mouse = true;
    baseIndex = 1;
    keyMode = "vi";
    historyLimit = 10000;
    terminal = "xterm-256color";

    plugins = with pkgs.tmuxPlugins; [
      sensible
    ];

    extraConfig = ''
      set-option -sa terminal-features ',xterm-256color:RGB'

      bind-key C-g send-prefix
      set -g renumber-windows on

      # binds for window management
      unbind '"'
      unbind %
      bind | split-window -h
      bind - split-window -v
      bind w new-window

      # kill window
      bind q killp

      # swap windows
      bind -r "<" swap-window -d -t -1
      bind -r ">" swap-window -d -t +1

      set-option -g allow-rename off
      set -g allow-passthrough on
      set -ga update-environment TERM
      set -ga update-environment TERM_PROGRAM
    '';
  };
}
