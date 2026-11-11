{
  flake.homeModules.misper-laptop = {
    config,
    lib,
    ...
  }: let
    aliases = {
      "cat" = "bat";
    };
  in {
    programs = with lib; {
      bat.enable = true;
      lsd = {
        enable = true;
        enableBashIntegration = config.programs.bash.enable;
        enableZshIntegration = config.programs.zsh.enable;
        enableFishIntegration = config.programs.fish.enable;
      };
      zsh.shellAliases = mkIf config.programs.zsh.enable aliases;
      bash.shellAliases = mkIf config.programs.bash.enable aliases;
      fish.shellAliases = mkIf config.programs.fish.enable aliases;
    };
  };
}
