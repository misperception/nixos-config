{
  flake.nixosModules.customOptions = { pkgs, config, lib, ... }: with lib; let
    cfg = config.misper.virtualization.podman;
  in {
    options.misper.virtualization.podman = {
      enable = mkEnableOption "Enable Podman";
      alias = mkEnableOption "Alias Podman to Docker";
      autoPrune = mkEnableOption "Automatically prune resources";
    };
    config = mkIf cfg.enable {
      virtualisation.podman = mkIf cfg.enable {
        enable = mkForce true;
	extraPackages = [ pkgs.podman-compose ];
	dockerSocket.enable = mkForce true;
	autoPrune.enable = cfg.autoPrune;
	dockerCompat = cfg.alias;
      };
    };
  };
}
