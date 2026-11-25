{inputs, ...}: {
  flake.homeModules.misper-pc = {
    imports = [inputs.agenix.homeManagerModules.default];
    age = {
      secrets = {
        proton-user.file = ./_secrets/proton/user.age;
        proton-password.file = ./_secrets/proton/password.age;
      };
      identityPaths = ["/home/misper/.ssh/id_ed25519"];
    };
  };
}
