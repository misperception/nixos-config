{
  flake.nixosModules.misper-server = {config, ...}: {
    virtualisation.oci-containers = {
      backend = "podman";
      containers = {
        estanteria-bot = {
          image = "docker.io/misperception/estanteria-bot";
          serviceName = "estanteria-bot";
          volumes = [
            "/home/misper/estanteria-bot-data:/app/data"
          ];
          environmentFiles = [
            config.age.secrets.estanteria-bot.path
          ];
        };
        vapbot = {
          image = "docker.io/misperception/vapbot";
          serviceName = "vapbot";
          environmentFiles = [
            config.age.secrets.vapbot.path
          ];
          environment = {
            PREFIX = "!";
            ID = "402186498373451777";
          };
        };
      };
    };
  };
}
