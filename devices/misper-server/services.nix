{
  services.github-nix-ci = {
    age.secretsDir = ./secrets;
    personalRunners = {
      "misperception/estanteria-bot".num = 1;
    };
  };
  services.copyparty = {
    enable = true;
    volumes = {
      "/" = {
        path = "/home/misper/share";
        access.rw = "*";
      };
    };
  };
}