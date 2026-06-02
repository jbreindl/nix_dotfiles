{
  description = "Home Manager configuration of jbreindl";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixgl = {
      url = "github:nix-community/nixGL";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-wallpaper = {
      url = "github:lunik1/nix-wallpaper";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      nixgl,
      nix-wallpaper,
      stylix,
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
      home-manager.backupFileExtension = "backup";
      homeConfigurations."home" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = sharedArgs;
        modules = [
          stylix.homeModules.stylix
          ./hosts/home.nix
        ];
      };
      homeConfigurations."work" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = sharedArgs;
        modules = [
          stylix.homeModules.stylix
          ./hosts/work.nix
        ];
      };
    };
}
