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
      lsp_signature-nvim
      lspkind-nvim
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
      vim-commentary
      vim-svelte
      which-key-nvim
      {
        plugin = gruvbox;
        type = "lua";
        config = ''
          local colorscheme = "gruvbox"
          vim.g.gruvbox_italic = 1
          local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
          if not status_ok then
              vim.notify("Colorscheme " .. colorscheme .. " not found!")
          end
        '';
      }
      {
        plugin = trouble-nvim;
        type = "lua";
        config = ''
          map("n", "<leader>lf", "<cmd>Trouble qflist toggle<cr>", opts)
        '';
      }
      {
        plugin = lspsaga-nvim;
        type = "lua";
        config = ''
          map('n', '<leader>lr', '<cmd>lua require("lspsaga.rename").rename()<CR>', opts)
          map('n', '<leader>lR', '<cmd>lua require("lspsaga.provider").lsp_finder()<CR>', opts)
          map('n', 'K', '<Cmd>lua require("lspsaga.hover").render_hover_doc()<CR>', opts)
          map('n', '<C-k>', '<cmd>lua require("lspsaga.signaturehelp").signature_help()<CR>', opts)
          map('i', '<C-k>', '<cmd>lua require("lspsaga.signaturehelp").signature_help()<CR>', opts)
          map('n', '<leader>la', '<cmd>lua require("lspsaga.codeaction").code_action()<CR>', opts)
          map('v', '<leader>la', ':<C-U>lua require("lspsaga.codeaction").range_code_action()<CR>', opts)
          map('n', '<leader>le', '<cmd>lua require("lspsaga.diagnostic").show_line_diagnostics()<CR>', opts)
        '';
      }
      {
        plugin = telescope-nvim;
        type = "lua";
        config = ''
          map("n", "<leader>p", [[<cmd>lua require("telescope.builtin").find_files()<cr>]], opts)
          map("n", "<leader><space>", [[<cmd>lua require("telescope.builtin").buffers()<cr>]], opts)
          map("n", "<leader>g", [[<cmd>lua require("telescope.builtin").live_grep()<cr>]], opts)
          map("n", "<leader>ls", [[<cmd>lua require("telescope.builtin").lsp_document_symbols()<cr>]], opts)
          map("n", "<leader>tf", [[<cmd>lua require("telescope.builtin").current_buffer_fuzzy_find()<cr>]], opts)
          map("n", "<leader>tt", [[<cmd>lua require("telescope.builtin").tags()<cr>]], opts)
          map("n", "<leader>t?", [[<cmd>lua require("telescope.builtin").oldfiles()<cr>]], opts)
          map("n", "<leader>tg", [[<cmd>lua require("telescope.builtin").grep_string()<cr>]], opts)
          map("n", "<leader>tp", [[<cmd>lua require("telescope.builtin").live_grep()<cr>]], opts)
          map("n", "<leader>tl", [[<cmd>lua require("telescope.builtin").tags{ only_current_buffer = true }<cr>]], opts)
          map("n", "<leader>tc", [[<cmd>lua require("telescope.builtin").git_commits()<cr>]], opts)
          map("n", "<leader>tb", [[<cmd>lua require("telescope.builtin").git_branches()<cr>]], opts)
          map("n", "<leader>ts", [[<cmd>lua require("telescope.builtin").git_status()<cr>]], opts)
          map("v", "<leader>rr", [[<Esc><cmd>lua require('telescope').extensions.refactoring.refactors()<CR>]], opts)
        '';
      }
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
          map('n', '<leader>le', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
          map('n', '<leader>lN', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
          map('n', '<leader>ln', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
        '';
      }
      {
        plugin = actions-preview-nvim;
        type = "lua";
        #config = ''
        #  vim.keymap.set({ "v", "n" }, "gf", require("actions-preview").code_actions)
        #'';
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
