{ config, pkgs, lib, ... }: {
  home.username = "ges";
  home.homeDirectory = "/home/ges";
  home.packages = with pkgs; [
    dialog
    networkmanager_dmenu
    networkmanagerapplet
    feh
    xcape
    xorg.xkbcomp
    xorg.xmodmap
    xorg.xrandr
  ];


  xdg.configHome = ~/.config;
  home.file = {
    "${config.xdg.configHome}/nvim" = { source = res/nvim; recursive = true; };
    "${config.xdg.configHome}/git" = { source = res/git; recursive = true; };
  };

  home.sessionVariables = {
  };

  xsession = {
    enable = true;
    windowManager.xmonad = {
      enable = true;
      enableContribAndExtras = true;
      config = ./config.hs;
      extraPackages = hp: [
        hp.dbus
	    hp.monad-logger
      ];
    };
  };

  services.gpg-agent = {
    enable = true;
    defaultCacheTtl = 1800;
    enableSshSupport = true;
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
    viAlias = true;
    withNodeJs = true;
    withRuby = true;
    extraPackages = with pkgs; [
      nodePackages.npm
      nodePackages.neovim
      nodePackages.pyright
      nodePackages.prettier
      nodePackages.eslint
      nodePackages.typescript
      nodePackages.typescript-language-server
      nodePackages.bash-language-server
      nodePackages.yaml-language-server
      nodePackages.dockerfile-language-server-nodejs
      nodePackages.vscode-langservers-extracted
      nodePackages.markdownlint-cli
      nodePackages.svelte-language-server
      lua-language-server
      selene
      statix
      nixpkgs-fmt
      nil
      clang-tools
      cppcheck
      shfmt
      shellcheck
      shellharden
      taplo-cli
      codespell
      gitlint
      terraform-ls
      actionlint
      ripgrep
      fd
      go
      gopls
      golangci-lint
      delve
      (python3.withPackages (ps: with ps; [
        setuptools
        flake8
        pylama
        black
        isort
        pylint
        yamllint
        debugpy
      ]))
    ];
    plugins = with pkgs.vimPlugins; [
      nvim-treesitter.withAllGrammars
      gruvbox
      nvim-cmp
      cmp-nvim-lsp
      cmp-buffer
      lspkind-nvim
      cmp-path
      cmp-cmdline
      cmp-nvim-lua
      luasnip
      nvim-navic
      lsp_signature-nvim
      lspsaga-nvim
      lualine-nvim
      mason-lspconfig-nvim
      mason-nvim
      nvim-autopairs
      mason-tool-installer-nvim
      null-ls-nvim
      nvim-colorizer-lua
      nui-nvim
      {
        plugin = nvim-lspconfig;
	    type = "lua";
	    config = ''
	      require("config.lsp")
          require("config.lsp_cmp")
        '';
      }
      {
        plugin = actions-preview-nvim;
        type = "lua";
        config = ''
          vim.keymap.set({ "v", "n" }, "gf", require("actions-preview").code_actions)
        '';
      }
      nvim-lsputils
      nvim-tree-lua
      nvim-web-devicons
      packer-nvim
      plenary-nvim
      telescope-nvim
      trouble-nvim
      vim-commentary
      which-key-nvim
    ];
    extraConfig = ''
    lua require('base')
'';
  };
  programs.home-manager.enable = true;
  home.stateVersion = "23.11";
}
