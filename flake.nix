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
    catppuccin-stable = {
      url = "github:catppuccin/nix?ref=release-25.11";
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };
    github-nix-ci.url = "github:juspay/github-nix-ci";
  };

  outputs = inputs: {
    nixosConfigurations = {
      misper-pc = inputs.nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ 
          ./options
          inputs.catppuccin.nixosModules.catppuccin
          ./devices/misper-pc
        ]; 
      };
      misper-laptop = inputs.nixpkgs.lib.nixosSystem {
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
          inputs.catppuccin-stable.nixosModules.catppuccin
          ./options
          ./devices/misper-server
          { environment.systemPackages = [inputs.agenix.packages.${system}.default]; }
        ];
      };
    };
  };
}
