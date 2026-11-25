{inputs, ...}: {
  flake.homeModules.misper-pc = {pkgs, ...}: {
    home.username = "misper";
    home.homeDirectory = "/home/misper";

    home.stateVersion = "24.05";

    imports = [
      inputs.catppuccin.homeModules.default
      inputs.nix-index.homeModules.default
    ];

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
      profiles.default.extensions = with pkgs.vscode-extensions; [
        catppuccin.catppuccin-vsc
        jnoortheen.nix-ide
        ms-python.python
        yzhang.markdown-all-in-one
      ];
      profiles.default.mutableUserSettings = true;
      profiles.default.userSettings = {
        "catppuccin.accentColor" = "mauve";
        "editor.semanticHighlighting.enabled" = true;
        "terminal.integrated.minimumContrastRatio" = 1;
        "window.titleBarStyle" = "custom";
        "workbench.colorTheme" = "Catppuccin Mocha";
        "editor.fontFamily" = "'JetBrainsMono Nerd Font', 'monospace', 'monospace'";
        "files.autoSave" = "on";
      };
    };

    # Enable Ablaze Floorp
    programs.floorp = {
      enable = true;
    };

    # Configure NeoVim
    programs.neovim = {
      enable = true;
      coc.enable = true;
      defaultEditor = true;
      withRuby = false;
      withPython3 = false;
      plugins = [
        pkgs.vimPlugins.nvim-cmp # Autocompletion
        {
          plugin = pkgs.vimPlugins.telescope-nvim;
          config = "nnoremap <leader>ff <cmd>Telescope find_files<cr>";
          type = "lua";
        } # Fuzzy finder
        pkgs.vimPlugins.which-key-nvim # Shortcut helper
      ];
    };

    programs.direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };

    # Configure GTK
    gtk = rec {
      enable = true;
      theme = {
        name = "Catppuccin-GTK-Mauve-Dark";
        package = pkgs.magnetic-catppuccin-gtk.override {
          accent = ["mauve"];
        };
      };
      gtk4.theme = theme;
    };

    # Configure QT
    qt = {
      enable = true;
      platformTheme.name = "kvantum";
      style.name = "kvantum";
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

    # Enable Comma
    programs.nix-index-database.comma.enable = true;

    # Populate man cache
    programs.man.generateCaches = true;

    programs.home-manager.enable = true;
  };
}
