{inputs, ...}: {
  flake.homeModules.misper-pc = {pkgs, ...}: {
    imports = [
      inputs.nix-flatpak.homeManagerModules.nix-flatpak
    ];
    home.packages = with pkgs; [
      blender
      (catppuccin-gtk.override {
        accents = ["mauve"];
        variant = "mocha";
        tweaks = ["normal"];
      })
      dolphin-emu
      eden
      file-roller
      gh
      gimp3
      gnome-tweaks
      inkscape
      keepassxc
      lazyssh
      obsidian
      onlyoffice-desktopeditors
      osu-lazer-bin
      pcsx2
      plezy
      prismlauncher
      protontricks
      python3
      qbittorrent
      rhythmbox
      rustup
      sgdboop
      steam-rom-manager
      thunderbird
      tree
      unofficial-homestuck-collection
      vesktop
      vlc
    ];
    services.flatpak = {
      enable = true;
      packages = [
        "com.github.tchx84.Flatseal"
        "org.vinegarhq.Sober"
      ];
    };
  };
}
