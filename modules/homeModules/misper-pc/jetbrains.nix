{
  flake.homeModules.misper-pc = {pkgs, ...}: {
    home.packages = with pkgs.jetbrains; [
      clion
      pycharm
      idea
    ];
  };
}
