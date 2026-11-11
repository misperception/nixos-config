{
  flake.homeModules.misper-laptop = {pkgs, ...}: {
    programs.neovim = {
      enable = true;
      coc.enable = true;
      defaultEditor = true;
      vimAlias = true;
      plugins = with pkgs.vimPlugins; [
        lightline-vim # Status bar
        telescope-nvim # Fuzzy finder
        which-key-nvim # Shortcut cheat sheet
      ];
      extraConfig = ''
        let mapleader = " "
        filetype on
        syntax on
        set number relativenumber
        set expandtab
        set shiftwidth=2
        set smartindent
        set ttyfast
          
        nmap <leader>f :FZF<CR>
      '';
    };
  };
}
