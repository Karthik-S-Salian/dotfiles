{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # REMOVE THIS ONCE THERE IS OFFICIAL SUPPORT
    zen-browser.url = "github:MarceColl/zen-browser-flake";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    nixosConfigurations = {
      dell = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/dell/configuration.nix
          inputs.home-manager.nixosModules.default
        ];
      };
      omen = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/omen/configuration.nix
          inputs.home-manager.nixosModules.default
        ];
      };
    };
  };
}
