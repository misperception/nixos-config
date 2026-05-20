let
  misper-server-system = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIArrnJJS+A8Hw2gjYBwdzj4mnB9bWwk9nYbPhW7XbTBt";
  misper-server-root = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGXRMbobkmT3kkYFvCvZpHVdFXhhuxVv7cHBQFTEnWj/";
  misper-pc = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGksX8pE5OS0QSiL1/9BAkYf1+/K82HroQviRy11ZMZ5";
  keyGroup = [ misper-server-system misper-server-root misper-pc ];
in {
  "github-nix-ci/misperception.token.age".publicKeys = keyGroup;
  "estanteria-bot.age".publicKeys = keyGroup;
  "vapbot.age".publicKeys = keyGroup;
  "beszel.age".publicKeys = keyGroup;
  "glance.age".publicKeys = keyGroup;
  "caddy.age".publicKeys = keyGroup;
}
