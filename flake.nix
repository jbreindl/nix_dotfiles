{
  description = "Home Manager configuration of jbreindl";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      # backupFileExtension = "backup";
    };
    nixgl = {
      url = "github:nix-community/nixGL";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-wallpaper = {
      url = "github:lunik1/nix-wallpaper";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      nixgl,
      nix-wallpaper,
      ...
    }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      sharedArgs = {
        inherit nixgl;
        inherit nix-wallpaper;
      };
    in
    {
      homeConfigurations."home" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = sharedArgs;
        modules = [ ./hosts/home.nix ];
      };
      homeConfigurations."work" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ ./hosts/work.nix ];
      };
    };
}
