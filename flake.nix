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
    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
    };
    zapp = {
      url = "github:zsa/zapp";
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
      nix-darwin,
      stylix,
      zen-browser,
      zapp,
      plasma-manager,
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
          zen-browser.homeModules.beta
          (
            { pkgs, ... }:
            {
              home.username = "jbr";
              home.homeDirectory = "/home/jbr/";
              imports = [
                ./modules/cli.nix
                ./modules/desktop.nix
              ];

              home.packages = with pkgs; [
                discord
                steam
                arduino-cli
                signal-desktop
              ];
              programs.git = {
                enable = true;
                settings = {
                  user = {
                    name = "Julius Breindl";
                    email = "juliusb1616@gmail.com";
                  };
                  init.defaultBranch = "main";
                };
              };
              programs.alacritty.enable = true;
            }
          )
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
          plasma-manager.homeModules.plasma-manager
          zen-browser.homeModules.beta
          (
            { pkgs, ... }:
            {
              home.username = "jbr";
              home.homeDirectory = "/home/jbr";
              imports = [
                ./modules/cli.nix
                ./modules/desktop.nix
                ./modules/kde.nix
              ];

              services.swaync.enable = false;
              home.packages = with pkgs; [
                glab
              ];

              targets = {
                # Make home-manager work better on non-NixOS
                genericLinux.enable = true;
                genericLinux.gpu.enable = true;
              };

              programs.git = {
                enable = true;
                settings = {
                  user = {
                    name = "Julius Breindl";
                    email = "jbr@condat.de";
                  };
                  init.defaultBranch = "main";
                  pull.rebase = true;
                };
                includes =
                  map
                    (dir: {
                      condition = "gitdir:${dir}";
                      contents.user.email = "juliusb1616@gmail.com";
                    })
                    [
                      "~/dev/personal/**"
                      "~/.config/**"
                    ];
              };
              xdg.configFile."git/ignore".source = ./work-gitignore;
            }
          )
          {
            nix.package = linuxPkgs.nix;
            nix.registry.nixpkgs.flake = nixpkgs;
            nix.nixPath = [ "nixpkgs=${nixpkgs}" ];
          }
        ];
      };

      homeConfigurations."work-server" = home-manager.lib.homeManagerConfiguration {
        pkgs = linuxPkgs;
        extraSpecialArgs = {
          isNixOS = false;
          inherit inputs;
        };
        modules = [
          {
            home.username = "jbr";
            home.homeDirectory = "/home/jbr";
            imports = [
              ./modules/cli.nix
            ];
          }
          {
            nix.package = linuxPkgs.nix;
            nix.registry.nixpkgs.flake = nixpkgs;
            nix.nixPath = [ "nixpkgs=${nixpkgs}" ];
          }
        ];
      };

      darwinConfigurations."mac-mini" = nix-darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        specialArgs = { inherit inputs; };
        modules = [
          home-manager.darwinModules.home-manager
          zapp.darwinModules.default

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
                users.jbr =
                  { pkgs, ... }:
                  {
                    imports = [
                      stylix.homeModules.stylix
                      ./modules/cli.nix
                      ./modules/ghostty.nix
                      ./modules/stylix.nix
                      ./modules/aerospace.nix
                      ./modules/ollama.nix
                      ./modules/opencode.nix
                    ];

                    home.packages = with pkgs; [
                      signal-desktop
                      ghostty-bin
                    ];
                    programs.git = {
                      enable = true;
                      settings = {
                        user = {
                          name = "Julius Breindl";
                          email = "juliusb1616@gmail.com";
                        };
                        init = {
                          defaultBranch = "main";
                        };
                      };
                      ignores = [
                        "*~"
                        "*.swp"
                        ".DS_Store"
                      ];
                    };
                  };
              };
            }
          )
        ];
      };
    };
}
