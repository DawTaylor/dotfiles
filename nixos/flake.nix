{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    caelestia-shell = {
      url = "github:caelestia-dots/shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sidra = {
      url = "github:wimpysworld/sidra";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, caelestia-shell, sidra, ... }:
    {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";

        modules = [
          ./configuration.nix

          home-manager.nixosModules.home-manager

          {
              home-manager = {
              useGlobalPkgs = true;
              users.daw = import ./home.nix;

              extraSpecialArgs = {
                inherit caelestia-shell;
                inherit sidra;
              };
            };
          }
        ];
      };
    };
}
