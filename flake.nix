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
    noctalia = {
      url = "github:noctalia-dev/noctalia";
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
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      nixgl,
      nix-wallpaper,
      noctalia,
      stylix,
      zen-browser,
      plasma-manager,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      sharedArgs = {
        inherit inputs;
      };
    in
    {
      homeConfigurations."home" = home-manager.lib.homeManagerConfiguration {

        inherit pkgs;
        extraSpecialArgs = { inherit inputs; };
        modules = [
          stylix.homeModules.stylix
          ./hosts/home.nix
          zen-browser.homeModules.beta
          plasma-manager.homeModules.plasma-manager
        ];
      };
      homeConfigurations."work" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = sharedArgs;
        modules = [
          stylix.homeModules.stylix
          ./hosts/work.nix
          zen-browser.homeModules.beta
        ];
      };
    };
}
