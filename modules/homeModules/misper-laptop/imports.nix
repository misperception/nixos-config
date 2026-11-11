{inputs, ...}: {
  flake.homeModules.misper-laptop = {
    imports = [
      inputs.agenix.homeManagerModules.default
      inputs.catppuccin.homeModules.default
      inputs.nix-index.homeModules.default
    ];
  };
}
