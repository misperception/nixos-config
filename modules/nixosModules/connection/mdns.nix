{
  flake.nixosModules.customOptions = {
    config,
    lib,
    ...
  }:
    with lib; let
      cfg = config.misper.connection.mdns;
    in {
      options.misper.connection.mdns.enable = mkEnableOption "mDNS (Avahi)";
      config = mkIf cfg.enable {
        services.avahi = {
          enable = true;
          openFirewall = true;
        };
      };
    };
}
