{ lib, inputs, system, home-manager, user, ... }:

{
  laptop = lib.nixosSystem {
    inherit system;
    specialArgs = { inherit user inputs; };
    modules = [
      ./configuration.nix
      
      home-manager.nixModules.home-manager {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = { inherit user; };
        home-manager.users.${user} = {
          imports = [( import ./home.nix )]
        };
      }
    ];
  };
}
