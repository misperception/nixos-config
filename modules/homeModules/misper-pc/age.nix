{
  flake.homeModules.misper-pc = {
    age = {
      secrets = {
        proton-user.file = ./_secrets/proton/user.age;
        proton-password.file = ./_secrets/proton/password.age;
      };
      identityPaths = ["/home/misper/.ssh/id_ed25519"];
    };
  };
}
