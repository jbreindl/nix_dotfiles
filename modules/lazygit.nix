{ pkgs, lib, ... }:
{
  programs.lazygit = {
    enable = true;
    # lazygit reads CONFIG_DIR, which project .env files also set
    package = pkgs.writeShellScriptBin "lazygit" ''
      unset CONFIG_DIR
      exec ${lib.getExe pkgs.lazygit} "$@"
    '';
    settings.gui.nerdFontsVersion = "3";
  };
}
