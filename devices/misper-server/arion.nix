{ config, ... }:
{
  age.secrets = {
    estanteria-bot.file = ./secrets/estanteria-bot.age;
    vapbot.file = ./secrets/vapbot.age;
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
    media-server.settings.services = {
      qbittorrent.service = let 
        WEBUI_PORT = 9200;
        TORRENTING_PORT = 9201;
      in {
        image = "lscr.io/linuxserver/qbittorrent:latest";
        container_name = "qbittorrent";
        restart = "unless-stopped";
        volumes = [
          "/home/misper/media-server/config/qbittorrent:/config"
          "/home/misper/media-server/downloads:/downloads"
        ];
        environment = {
          PUID=1000;
          PGID=1000;
          Tz="Europe/Madrid";
          WEBUI_PORT=WEBUI_PORT;
          TORRENTING_PORT=TORRENTING_PORT;
        };
        ports = [
          "${toString WEBUI_PORT}:${toString WEBUI_PORT}"
          "${toString TORRENTING_PORT}:${toString TORRENTING_PORT}"
          "${toString TORRENTING_PORT}:${toString TORRENTING_PORT}/udp"
        ];
      };
    };
  };
}