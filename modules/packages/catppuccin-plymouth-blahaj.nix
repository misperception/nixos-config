{
  perSystem = { pkgs, ... }: {
    packages.catppuccin-plymouth-blahaj = pkgs.plymouth-blahaj-theme.overrideAttrs (old: {
      src = pkgs.fetchurl {
        url = "https://github.com/misperception/catppuccin-plymouth-blahaj/releases/download/v.1.0.0/blahaj.tar.gz";
        sha256 = "sha256-lQumew3X+fu7501HBz08uecqxrF88M1XIIYvAi9FbeM=";
      };
    });
  };
}