{ pkgs, ... }: {
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
    viAlias = true;
    withNodeJs = true;
    withRuby = true;
    extraPackages = with pkgs; [
      actionlint
      clang-tools
      codespell
      cppcheck
      delve
      fd
      gitlint
      go
      golangci-lint
      gopls
      lua-language-server
      nil
      nixpkgs-fmt
      nodePackages.bash-language-server
      nodePackages.dockerfile-language-server-nodejs
      nodePackages.eslint
      nodePackages.markdownlint-cli
      nodePackages.neovim
      nodePackages.npm
      nodePackages.prettier
      nodePackages.pyright
      nodePackages.svelte-language-server
      nodePackages.svelte-check
      nodePackages.typescript
      nodePackages.typescript-language-server
      nodePackages.vscode-langservers-extracted
      nodePackages.yaml-language-server
      ocamlPackages.ocamlformat
      jdt-language-server
      ripgrep
      selene
      shellcheck
      shellharden
      shfmt
      vscode-extensions.vscjava.vscode-java-test
      vscode-extensions.vscjava.vscode-java-debug
      statix
      taplo-cli
      terraform-ls
      (python3.withPackages (ps:
        with ps; [
          black
          debugpy
          flake8
          isort
          pylama
          pylint
          setuptools
          yamllint
        ]))
    ];
    plugins = with pkgs.vimPlugins; [
      cmp-buffer
      cmp-cmdline
      cmp-nvim-lsp
      cmp-nvim-lua
      cmp-path
      cmp_luasnip
      gruvbox
      lsp_signature-nvim
      lspkind-nvim
      lspsaga-nvim
      lualine-nvim
      luasnip
      mason-lspconfig-nvim
      mason-nvim
      mason-tool-installer-nvim
      nui-nvim
      null-ls-nvim
      nvim-autopairs
      nvim-cmp
      nvim-colorizer-lua
      nvim-lsputils 
      nvim-navic
      nvim-treesitter.withAllGrammars
      nvim-web-devicons
      packer-nvim
      plenary-nvim
      rustaceanvim
      telescope-nvim
      trouble-nvim
      vim-commentary
      vim-svelte
      which-key-nvim
      {
        plugin = nvim-jdtls;
        type = "lua";
        config = ''
          vim.api.nvim_create_autocmd("FileType", {
            pattern = "java",
            callback = function()
              require("jdtls").setup()
            end
          })
        '';
      }
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
      {
        plugin = nvim-tree-lua;
        type = "lua";
        config = ''
          require("nvim-web-devicons").setup()
          require("nvim-tree").setup()
          vim.api.nvim_set_keymap("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", {noremap = true})
        '';
      }
    ];
    extraConfig = ''
      lua require('base')
    '';
  };
}
