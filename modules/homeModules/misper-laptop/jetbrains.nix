{
  flake.homeModules.misper-laptop = {pkgs, ...}: {
    home.packages = with pkgs.jetbrains; [
      clion
      pycharm
      idea
    ];
  };
}
