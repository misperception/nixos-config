{inputs, ...}: {
  flake.homeModules.misper-laptop = {pkgs, ...}: {
    home.username = "misper";
    home.homeDirectory = "/home/misper";
    home.stateVersion = "24.05";

    # Import modules.
    imports = [
      inputs.zen-browser.homeModules.beta
    ];

    home.packages =
      (with pkgs; [
        bat
        gh
        gnome-tweaks
        lsd
        onlyoffice-desktopeditors
        obsidian
        python3
        thunderbird
        tree
        vesktop
        zoxide
      ])
      ++ (with pkgs.gnomeExtensions; [
        user-themes
        system-monitor
      ]);

    # Enable the Zen Browser
    programs.zen-browser.enable = true;

    # Enable direnv
    programs.direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };

    programs.gh = {
      enable = true;
      gitCredentialHelper.enable = true;
    };

    # Catppuccin configuration
    catppuccin = {
      enable = true;
      autoEnable = true;
      flavor = "mocha";
      accent = "mauve";
      cursors = {
        enable = true;
        flavor = "mocha";
        accent = "light";
      };
    };

    home.pointerCursor.enable = true;

    # Configure VSCodium
    programs.vscodium = {
      enable = true;
      profiles.default.mutableUserSettings = true;
      profiles.default.extensions = with pkgs.vscode-extensions; [
        catppuccin.catppuccin-vsc
        jnoortheen.nix-ide
        ms-python.python
        yzhang.markdown-all-in-one
        vscode-icons-team.vscode-icons
      ];
    };

    # Manage GTK Theme
    gtk = rec {
      enable = true;
      font.name = "Cantarell";
      gtk4.font.name = font.name;
      theme = {
        package = pkgs.magnetic-catppuccin-gtk.override {
          accent = ["mauve"];
        };
        name = "Catppuccin-GTK-Mauve-Dark";
      };
      gtk4.theme = theme;
    };

    # Configure the Kitty terminal.
    programs.kitty = {
      enable = true;
      shellIntegration.enableZshIntegration = true;
      font = {
        name = "JetBrainsMono Nerd Font";
        size = 13;
      };
      settings = {
        tab_bar_edge = "top";
        tab_bar_style = "powerline";
        tab_powerline_style = "slanted";
        tab_bar_align = "left";
        tab_bar_background = "none";
        wayland_titlebar_color = "background";
        background_opacity = "0.7";
        background_blur = 30;
      };
    };

    programs.nix-index.enable = true;
    programs.nix-index-database.comma.enable = true;

    # Configure Hyfetch
    programs.hyfetch = {
      enable = true;
      settings = {
        preset = "demiboy";
        mode = "rgb";
        color_align = {
          mode = "horizontal";
        };
      };
    };

    # Configure Btop++
    programs.btop = {
      enable = true;
      settings = {
        theme_background = true;
        truecolor = true;
        update_ms = 2000;
        proc_mem_bytes = false;
      };
    };

    # Enable Java
    programs.java.enable = true;

    # Shell configuration
    programs.zsh = {
      enable = true;
      enableCompletion = true;
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
      shellAliases = {
        "nix-edit" = "sudo $EDITOR /etc/nixos/configuration.nix";
        "home-edit" = "$EDITOR ~/.config/home-manager/home.nix";
        "cd" = "z";
      };
    };
    xdg.autostart.enable = true;
    programs.keepassxc = {
      enable = true;
      autostart = true;
    };

    nix.gc = {
      automatic = true;
      dates = ["11:00"];
      persistent = true;
    };

    programs.home-manager.enable = true;
  };
}
