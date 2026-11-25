{inputs, ...}: {
  flake.homeModules.misper-pc = {pkgs, ...}: let
    spicetifyPkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
  in {
    imports = [inputs.spicetify-nix.homeManagerModules.default];

    programs.spicetify = {
      enable = true;
      theme = spicetifyPkgs.themes.text;
      colorScheme = "CatppuccinMocha";

      enabledExtensions = with spicetifyPkgs.extensions; [
        powerBar
        adblock
        hidePodcasts
        autoSkipVideo
        keyboardShortcut
        beautifulLyrics
      ];

      enabledCustomApps = with spicetifyPkgs.apps; [
        marketplace
        lyricsPlus
        localFiles
      ];
    };
  };
}
