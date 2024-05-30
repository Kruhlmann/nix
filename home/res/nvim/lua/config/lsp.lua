local lsp_config = require("lspconfig")
local lsp_signature = require("lsp_signature")
local navic = require("nvim-navic")
local servers = {
    clangd = {},
    nil_ls = {},
    pyright = {},
    dockerls = {},
    bashls = {},
    terraformls = {},
    ocamllsp = {},
    gopls = {},
    svelte = {},
    tsserver = {},
    rust_analyzer = {},
    jdtls = {},
    ruff_lsp = {},
    taplo = {},
    eslint = { cmd = { "eslint", "--stdio" } },
    jsonls = { cmd = { "vscode-json-languageserver", "--stdio" } },
    lua_ls = {
        cmd = { "lua-language-server" },
        settings = {
            Lua = {
                diagnostics = {
                    globals = { "vim" },
                },
                workspace = {
                    library = {
                        [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                        [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
                    },
                    maxPreload = 10000,
                },
            },
        },
    },
    texlab = {
        settings = {
            texlab = {
                build = {
                    onSave = true,
                    forwardSearchAfter = true,
                },
                forwardSearch = {
                    executable = "zathura",
                    args = { "--synctex-forward", "%l:1:%f", "%p" },
                },
                chktex = {
                    onOpenAndSave = true,
                },
            },
        },
    },
}

local common_on_attach = function(client, bufnr)
    local function buf_set_keymap(...)
        vim.api.nvim_buf_set_keymap(bufnr, ...)
    end

    local function buf_set_option(...)
        vim.api.nvim_buf_set_option(bufnr, ...)
    end

    local opts = { noremap = true, silent = true }
    buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
    buf_set_keymap('n', '<leader>ld', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', '<leader>lD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    buf_set_keymap('n', '<leader>li', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    buf_set_keymap('n', '<leader>la', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    buf_set_keymap("n", "<leader>le", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
    buf_set_keymap('n', '<leader>lN', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
    buf_set_keymap('n', '<leader>ln', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
    buf_set_keymap("n", "<leader>lR", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
    buf_set_keymap("n", "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)

    buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

    vim.cmd [[autocmd BufWritePre * lua vim.lsp.buf.format()]]

    lsp_signature.on_attach({
        floating_window_above_cur_line = true,
    })

    if client.server_capabilities.documentSymbolProvider then
        navic.attach(client, bufnr)
    end
end

local common_capabilities = vim.lsp.protocol.make_client_capabilities()

for server, config in pairs(servers) do
    if server ~= "jdtls" then
        config = vim.tbl_deep_extend("force", {
            on_attach = common_on_attach,
            capabilities = common_capabilities,
        }, config)
        lsp_config[server].setup(config)
    end
end
