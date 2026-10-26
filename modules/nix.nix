{ pkgs, ... }:
{
  nix = {
    package = pkgs.nix;   # or pkgs.lix, pkgs.nixVersions.latest, etc.

    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      max-jobs = "auto";
    };

  };
}
