let 
  makeDrive = root: {
    device = "/dev/disk/by-uuid/${root}";
    fsType = "ext4";
  };
in {
  fileSystems = {
      # 1TB HDD @ /run/media/misper/data
      "/run/media/misper/data" = (makeDrive "a6ecceb0-3a59-4057-bef3-863453470607");
      # 128 SDD @ /run/media/misper/games
      "/run/media/misper/games" = (makeDrive "076e290f-f281-4f77-a44a-a1f9b259d1b4");
  };
}
