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
        noctalia-pkg = noctalia.packages.${system}.default;
        home-manager.backupFileExtension = "backup";
        home-manager.news.display = "silent";
      };
    in
    {
      homeConfigurations."home" = home-manager.lib.homeManagerConfiguration {

        inherit pkgs;
        extraSpecialArgs = sharedArgs;
        modules = [
          stylix.homeModules.stylix
          ./hosts/home.nix
          zen-browser.homeModules.beta
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
