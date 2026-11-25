{
  flake.homeModules.misper-laptop = {
    # Starship prompt configuration.
    programs.starship = {
      enable = true;
      enableZshIntegration = true;
      settings = {
        add_newline = true;
        format = "[ ](sky)$os[ ](bg:sapphire fg:sky)$username[ ](bg:sapphire)[ ](bg:blue fg:sapphire)$hostname[ ](bg:blue)[ ](bg:lavender fg:blue)$directory[ ](bg:lavender)[ ](bg:surface0 fg:lavender)$c$nix_shell$python$git_branch[ ](bg:surface0)[ ](surface0)";
        os = {
          disabled = false;
          symbols = {NixOS = " ";};
          style = "bg:sky fg:base";
        };

        username = {
          show_always = true;
          style_user = "bg:sapphire fg:base";
          style_root = "bg:sapphire fg:mauve";
          format = "[  $user]($style)";
        };

        hostname = {
          ssh_only = false;
          ssh_symbol = " ";
          format = "[$ssh_symbol󰍹  $hostname]($style)";
          style = "bg:blue fg:base";
        };

        directory = {
          disabled = false;
          format = "[$path]($style)[$read_only]($read_only_style)";
          style = "bg:lavender fg:base";
          home_symbol = "󰜥 ";
          read_only_style = "bg:lavender fg:mauve";
        };

        c = {
          disabled = false;
          symbol = " ";
          format = "[$symbol($version(-$name))]($style)";
          style = "bg:surface0 fg:text";
        };

        nix_shell = {
          disabled = false;
          symbol = "  ";
          format = "[$symbol$state \($name\)]($style)";
          style = "bg:surface0 fg:text";
        };

        python = {
          disabled = false;
          symbol = " ";
          format = "[$symbol$pyenv_prefix ($version)(\($virtualenv\))]($style)";
          style = "bg:surface0 fg:text";
        };

        git_branch = {
          disabled = false;
          symbol = " ";
          format = "[$symbol$branch]($style)";
          style = "bg:surface0 fg:text";
        };
      };
    };
  };
}
