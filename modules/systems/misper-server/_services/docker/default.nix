{ config, ... }:
{
  age.secrets = {
    estanteria-bot.file = ../../_secrets/estanteria-bot.age;
    vapbot.file = ../../_secrets/vapbot.age;
  };
  virtualisation.oci-containers = {
    backend = "docker";
    containers = {
      estanteria-bot = {
        image = "misperception/estanteria-bot";
        serviceName = "estanteria-bot";
        volumes = [
          "/home/misper/estanteria-bot-data:/app/data"
        ];
        environmentFiles = [
          config.age.secrets.estanteria-bot.path
        ];
      };
      vapbot = {
        image = "misperception/vapbot";
        serviceName = "vapbot";
        environmentFiles = [
          config.age.secrets.vapbot.path
        ];
        environment = {
          PREFIX="!";
          ID="402186498373451777";
        };
      };
    };
  };
}
