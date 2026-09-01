{ config, lib, ... }:
{
  age.secrets = {
    caddy.file = ../secrets/caddy.age;
  };
  services.caddy = let
      domain = "misper-server.net"; 
    in {
    enable = true;
    user = "root";
    group = "root";
    dataDir = "/media-server/config/caddy";
    acmeCA = "https://acme-staging-v02.api.letsencrypt.org/directory";
    environmentFile = config.age.secrets.caddy.path;
    email = "{\$EMAIL}";
    virtualHosts = let 
      makeReverseProxy = port: { extraConfig = "reverse_proxy localhost:${toString port}"; };
      makeAliases = aliases: { serverAliases = lib.forEach aliases (alias: "http://${alias}.${domain}"); };
    in {
      "http://${domain}" = makeReverseProxy 5995 // makeAliases [ "www" "home" ];
    };
  };
}