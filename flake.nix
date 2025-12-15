{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs?ref=nixos-25.11";
    catppuccin.url = "github:catppuccin/nix";
    catppuccin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, nixpkgs-stable, catppuccin }: {
    nixosConfigurations = {
      misper-pc = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ 
          ./configuration.nix
          catppuccin.nixosModules.catppuccin
          ./modules/misper-pc.nix
        ]; 
      };
      misper-laptop = nixpkgs-stable.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
          catppuccin.nixosModules.catppuccin
          ./modules/misper-laptop.nix
        ];
      };
      misper-server = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
          ./modules/misper-server.nix
        ];
      };
    };
  };
}
