{ pkgs, ... }:

{
  home.packages = with pkgs; [
    kitty
  ];
  programs.kitty = {
    enable = true;
    settings = {
      enable_audio_bell = false;
    };
  };
}
