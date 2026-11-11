let
  misper-pc-key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGksX8pE5OS0QSiL1/9BAkYf1+/K82HroQviRy11ZMZ5";
  misper-pc-root = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIL4ChckQwxT76d16Gg2J0GHshDx9oVHKbubCJhWGXCYH";
  misper-laptop-key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIq6R+bdZ18/VijL4Nh7bqy2dUARo3YR9MeLLW1ciMxU";
  key-group = [ misper-pc-key misper-pc-root misper-laptop-key ];
in {
  "proton/user.age".publicKeys = key-group;
  "proton/password.age".publicKeys = key-group;
}