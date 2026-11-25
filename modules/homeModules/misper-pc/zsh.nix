{
  flake.homeModules.misper-pc = {
    pkgs,
    config,
    ...
  }: {
    # Configure Zsh
    programs.zsh = {
      enable = true;
      enableCompletion = true;
      dotDir = "${config.xdg.configHome}/zsh";
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      autocd = true;
      oh-my-zsh = {
        enable = true;
        plugins = [
          "zoxide"
          "direnv"
        ];
      };
      initContent = "source ${pkgs.zsh-nix-shell}/share/zsh-nix-shell/nix-shell.plugin.zsh";
    };

    # Enable Zsh in Kitty
    programs.kitty.shellIntegration.enableZshIntegration = true;
    # Enable Starship prompt
    programs.starship.enableZshIntegration = true;
    # Enable "command not found but can be installed" message
    programs.nix-index = {
      enable = true;
      enableZshIntegration = true;
    };

    # Required packages by Zsh modules
    home.packages = with pkgs; [
      zoxide
      zsh-nix-shell
    ];
  };
}
