{ config, ... }:
{
  age.secrets = {
    estanteria-bot.file = ./secrets/estanteria-bot.age;
    vapbot.file = ./secrets/vapbot.age;
    plex.file = ./secrets/plex.age;
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
          "/home/misper/media-server/data/downloads:/data/downloads"
        ];
        environment = {
          PUID=1000;
          PGID=1000;
          UMASK=002;
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
      prowlarr.service = {
        image = "lscr.io/linuxserver/prowlarr:latest";
        container_name = "prowlarr";
        restart = "unless-stopped";
        volumes = [
          "/home/misper/media-server/config/prowlarr:/config"
        ];
        environment = {
          PUID=1000;
          PGID=1000;
          UMASK=002;
          TZ="Europe/Madrid";
        };
        ports = [ "9696:9696" ];
      };
      shoko.service = {
        image = "ghcr.io/shokoanime/server:latest";
        container_name = "shoko";
        restart = "unless-stopped";
        volumes = [
          "/home/misper/media-server/config/shoko:/home/shoko/.shoko"
          "/home/misper/media-server/data/anime:/data/anime"
        ];
        environment = {
          PUID=1000;
          PGID=1000;
          UMASK=002;
          TZ="Europe/Madrid";
        };
        ports = [ "8111:8111" ];
      };
      sonarr.service = {
        image = "ghcr.io/hotio/sonarr:latest";
        container_name = "sonarr";
        restart = "unless-stopped";
        volumes = [
          "/home/misper/media-server/config/sonarr:/config"
          "/home/misper/media-server/data:/data"
        ];
        environment = {
          PUID=1000;
          PGID=1000;
          UMASK=002;
          TZ="Europe/Madrid";
          WEBUI_PORTS="8989/tcp";
        };
        ports = [ "8989:8989" ];
      };
      seerr.service = {
        image = "ghcr.io/seerr-team/seerr:latest";
        container_name = "seerr";
        restart = "unless-stopped";
        volumes = [
          "/home/misper/media-server/config/seerr:/app/config"
        ];
        environment = {
          PUID=1000;
          PGID=1000;
          UMASK=002;
          TZ="Europe/Madrid";
          PORT=5055;
        };
        ports = [ "5055:5055" ];
      };
      plex.service = {
        image = "plexinc/pms-docker:latest";
        container_name = "plex";
        restart = "unless-stopped";
        volumes = [
          "/home/misper/media-server/config/plex:/config"
          "/home/misper/media-server/data:/data"
        ];
        environment = {
          PUID=1000;
          PGID=1000;
          UMASK=002;
          TZ="Europe/Madrid";
        };
        env_file = [
          config.age.secrets.plex.path
        ];
        ports = [
          "32400:32400"
        ];
      };
    };
  };
}