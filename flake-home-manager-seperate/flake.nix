{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-22.05";
    home-manager = {
      url = github:nix-community/home-manager;
      inputs.nixpkgs.follows = "nixpkgs";
    }
  };

  outputs = { self, nixpkgs, home-manager }: # notice no curly brackets here because we use vars
    let
      system = "x86_64-linux"; # this isn't strictly nessecary,
      # but it would be a pain not to
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;  # allows non-foss 
      };
      lib = nixpkgs.lib;
      #hostname = "yolo"
    in {
      nixosConfigurations = {
        yolo = lib.nixosSystem {
          inherit system;
          modules = [ ./configuration.nix ];
        };
      };
      hmConfig = {
        yolo = home-manager.lib.homeManagerConfiguration {
          inherit system pkgs;
          #stateVersion = "some version string" # optional
          username = "yolo";
          homeDirectory = "/home/yolo";
          configuration = {
            imports = [
              ./home.nix
            ]
          }
        }
      }
    };
  }
