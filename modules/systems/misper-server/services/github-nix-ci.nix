{
  services.github-nix-ci = {
    age.secretsDir = ../secrets;
    personalRunners = {
      "misperception/estanteria-bot".num = 1;
    };
  };
}