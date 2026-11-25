{
  flake.homeModules.misper-laptop = {config, ...}: {
    programs.rclone = {
      enable = true;
      requiresUnit = "agenix.service";
      remotes.proton = {
        config = {
          type = "protondrive";
        };
        secrets = {
          username = config.age.secrets.proton-user.path;
          password = config.age.secrets.proton-password.path;
        };
        mounts."/" = {
          enable = true;
          mountPoint = "${config.home.homeDirectory}/drive";
        };
      };
    };
  };
}
