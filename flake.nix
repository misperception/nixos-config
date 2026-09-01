{
  inputs = {
    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    arion = {
      url = "github:hercules-ci/arion";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs?ref=nixos-25.11";
    catppuccin = {
      url = "github:catppuccin/nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    github-nix-ci.url = "github:juspay/github-nix-ci";
  };

  outputs = { nixpkgs, ... } @inputs: {
    nixosConfigurations = {
      misper-pc = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ 
          ./options
          inputs.catppuccin.nixosModules.catppuccin
          ./devices/misper-pc
        ]; 
      };
      misper-laptop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./options
          inputs.catppuccin.nixosModules.catppuccin
          ./devices/misper-laptop
        ];
      };
      misper-server = inputs.nixpkgs-stable.lib.nixosSystem rec {
        system = "x86_64-linux";
        modules = [
          inputs.agenix.nixosModules.default
          inputs.arion.nixosModules.arion
          inputs.github-nix-ci.nixosModules.default
          ./options
          ./devices/misper-server
          { environment.systemPackages = [inputs.agenix.packages.${system}.default]; }
        ];
      };
    };
  };
}
