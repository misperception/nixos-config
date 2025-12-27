let
  misper-server = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIArrnJJS+A8Hw2gjYBwdzj4mnB9bWwk9nYbPhW7XbTBt";
in {
  "github-nix-ci/misperception.token.age".publicKeys = [ misper-server ];
}