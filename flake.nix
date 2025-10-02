{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    catppuccin.url = "github:catppuccin/nix";
    catppuccin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, catppuccin }: {
    nixosConfigurations = {
      misper-pc = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ 
          ./configuration.nix
          catppuccin.nixosModules.catppuccin
          ./modules/misper-pc.nix
        ]; 
      };
      misper-laptop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
          catppuccin.nixosModules.catppuccin
          ./modules/misper-laptop.nix
        ];
      };
    };
  };
}
