{ config, ... }:
{
  age.secrets = {
    estanteria-bot.file = ../../_secrets/estanteria-bot.age;
    vapbot.file = ../../_secrets/vapbot.age;
  };
  virtualisation.arion.backend = "docker";
  virtualisation.arion.projects = {
    bots.settings.services = {
      estanteria-bot.service = {
        image = "misperception/estanteria-bot";
        container_name = "estanteria-bot";
        restart = "unless-stopped";
        volumes = [
          "/home/misper/estanteria-bot-data:/app/data"
        ];
        env_file = [
          config.age.secrets.estanteria-bot.path
        ];
      };
      vapbot.service = {
        image = "misperception/vapbot";
        container_name = "vapbot";
        restart = "unless-stopped";
        env_file = [
          config.age.secrets.vapbot.path
        ];
        environment = {
          PREFIX="!";
          ID=402186498373451777;
        };
      };
    };
  };
}
