{
  services.github-nix-ci = {
    age.secretsDir = ../_secrets;
    personalRunners = {
      "misperception/estanteria-bot".num = 1;
    };
  };
}