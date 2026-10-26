{
  description = "Home Manager configuration of jbreindl";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-darwin = {
      url = "github:nix-darwin/nix-darwin";
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
    nixvim = {
      url = "github:nix-community/nixvim";
      # inputs.nixpkgs.follows = "nixpkgs";
    };
    zapp = {
      url = "github:zsa/zapp";
    };
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      nix-darwin,
      stylix,
      zen-browser,
      nixvim,
      zapp,
      ...
    }@inputs:
    let
      mkPkgs =
        system:
        import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };
      linuxPkgs = mkPkgs "x86_64-linux";
    in
    {
      homeConfigurations."home" = home-manager.lib.homeManagerConfiguration {
        pkgs = linuxPkgs;
        extraSpecialArgs = {
          isNixOS = true;
          inherit inputs;
        };
        modules = [
          stylix.homeModules.stylix
          ./hosts/home.nix
          zen-browser.homeModules.beta
          nixvim.homeModules.nixvim
        ];
      };

      homeConfigurations."work" = home-manager.lib.homeManagerConfiguration {
        pkgs = linuxPkgs;
        extraSpecialArgs = {
          isNixOS = false;
          inherit inputs;
        };
        modules = [
          stylix.homeModules.stylix
          ./hosts/work.nix
          zen-browser.homeModules.beta
          nixvim.homeModules.nixvim
        ];
      };

      homeConfigurations."work-server" = home-manager.lib.homeManagerConfiguration {
        pkgs = linuxPkgs;
        extraSpecialArgs = {
          isNixOS = false;
          inherit inputs;
        };
        modules = [ ./hosts/work-server.nix ];
      };

      darwinConfigurations."mac-mini" = nix-darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        specialArgs = { inherit inputs; };
        modules = [
          home-manager.darwinModules.home-manager
          zapp.darwinModules.default
          # ./modules/sketchybar.nix

          (
            { ... }:
            {

              programs.zapp.enable = true;
              nixpkgs.config.allowUnfree = true;
              nix.settings.trusted-users = [
                "root"
                "jbr"
              ];
              system.stateVersion = 5;
              system.primaryUser = "jbr";

              users.users.jbr = {
                name = "jbr";
                home = "/Users/jbr";
              };

              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                backupFileExtension = "backup";
                extraSpecialArgs = {
                  isNixOS = false;
                  inherit inputs;
                };
                users.jbr = {
                  imports = [
                    stylix.homeModules.stylix
                    nixvim.homeModules.nixvim
                    ./hosts/mac-mini.nix
                  ];
                };
              };
            }
          )
        ];
      };
    };
}
