{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-22.05";
  };

  outputs = { self, nixpkgs }: # notice no curly brackets here because we use vars
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
    };
  }
