{ pkgs, ...}:
{
  # Configure the Docker Daemon
  virtualisation.docker = {
    enable = true;
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
    daemon.settings = {
      data-root = "/home/misper/Docker";
      userland-proxy = false;
    };
  };

  # Add user to Docker group
  users.extraGroups.docker.members = [ "misper" ];
}
