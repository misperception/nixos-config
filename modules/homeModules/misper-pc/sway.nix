# Will obviously change this to something that respects the dendritic pattern
# + I will probably publish my sway config as its own flake in the future
{
  flake.homeModules.misper-pc = {
    imports = [./_sway];
  };
}
