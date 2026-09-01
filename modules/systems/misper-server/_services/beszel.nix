{ config, ... }:
{
  age.secrets = {
    beszel.file = ../_secrets/beszel.age;
  };
  services.beszel = {
    hub = {
      enable = true;
      host = "0.0.0.0";
      port = 8888;
    };
    agent = {
      enable = true;
      smartmon.enable = true;
      openFirewall = true;
      environmentFile = config.age.secrets.beszel.path;
    };
  };
}