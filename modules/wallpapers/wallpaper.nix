# modules/wallpapers/default.nix
{ config, lib, ... }:
{
  options.wallpaper.image = lib.mkOption {
    type = lib.types.path;
    description = "Active wallpaper image; consumed by whichever WM module is imported.";
  };
}
