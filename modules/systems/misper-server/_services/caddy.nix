{ config, lib, ... }:
{
  age.secrets = {
    caddy.file = ../_secrets/caddy.age;
  };
  services.caddy = let
      domain = "misper-server.net"; 
    in {
    enable = true;
    # change once i get an actual working domain
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