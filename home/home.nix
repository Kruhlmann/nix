{ config, pkgs, ... }:
let
  lspServers = pkgs.writeText "lsp_servers.json" (builtins.toJSON (import ./lsp_servers.nix { inherit pkgs; }));
in
{
  home.username = "ges";
  home.homeDirectory = "/home/ges";
  home.stateVersion = "23.11"; # Please read the comment before changing.
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
    #"${config.xdg.configHome}/nvim" = { source = dotfiles/.config/nvim; recursive = true; };
    "${config.xdg.configHome}/git" = { source = dotfiles/.config/git; recursive = true; };
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
      nodePackages.typescript-language-server
      nodePackages.bash-language-server
      nodePackages.yaml-language-server
      nodePackages.dockerfile-language-server-nodejs
      nodePackages.vscode-langservers-extracted
      nodePackages.markdownlint-cli
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
      gruvbox
      nvim-cmp
      cmp-nvim-lsp
      cmp-buffer
      cmp-path
      cmp-cmdline
      cmp-nvim-lua
      luasnip
      lsp_signature-nvim
      lspsaga-nvim
      lualine-nvim
      mason-lspconfig-nvim
      mason-nvim
      mason-tool-installer-nvim
      null-ls-nvim
      nvim-colorizer-lua
      nui-nvim
      {
        plugin = nvim-lspconfig;
	    type = "lua";
	    config = ''
	      require("config.lsp").setup_servers("${lspServers}")
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
      nvim-treesitter
      nvim-treesitter-endwise
      nvim-treesitter-textobjects
      nvim-treesitter.withAllGrammars
      nvim-web-devicons
      packer-nvim
      plenary-nvim
      telescope-nvim
      trouble-nvim
      vim-commentary
      which-key-nvim
    ];
  };
  programs.home-manager.enable = true;
}
