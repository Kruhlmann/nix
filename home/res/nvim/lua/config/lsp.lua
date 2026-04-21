for _, method in ipairs({ 'textDocument/diagnostic', 'workspace/diagnostic' }) do
    local default_diagnostic_handler = vim.lsp.handlers[method]
    vim.lsp.handlers[method] = function(err, result, context, config)
        if err ~= nil and err.code == -32802 then
            return
        end
        return default_diagnostic_handler(err, result, context, config)
    end
end

local lsp_signature = require("lsp_signature")
local navic = require("nvim-navic")

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
    buf_set_keymap('n', '<leader>lN', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
    buf_set_keymap('n', '<leader>ln', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
    buf_set_keymap("n", "<leader>lR", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
    buf_set_keymap("n", "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)

    buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

    vim.api.nvim_create_autocmd("BufWritePre", {
        buffer = bufnr,
        callback = function()
            vim.lsp.buf.format({ bufnr = bufnr })
        end,
    })

    lsp_signature.on_attach({
        floating_window_above_cur_line = true,
    })

    if client.server_capabilities.documentSymbolProvider then
        navic.attach(client, bufnr)
    end
end

local common_capabilities = vim.lsp.protocol.make_client_capabilities()

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
    ts_ls = {},
    rust_analyzer = {
        settings = {
            ["rust-analyzer"] = {
                cargo = {
                    allFeatures = true,
                },
            },
        },
    },
    ruff = {},
    taplo = {},
    eslint = {
        on_attach = function(_, bufnr)
            local base_attach = common_on_attach
            base_attach(_, bufnr)
            vim.api.nvim_create_autocmd("BufWritePre", {
                buffer = bufnr,
                command = "EslintFixAll",
            })
        end,
    },
    jsonls = { cmd = { "vscode-json-languageserver", "--stdio" } },
    lua_ls = {
        cmd = { "lua-language-server" },
        settings = {
            Lua = {
                diagnostics = {
                    globals = { "vim" },
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

for server, config in pairs(servers) do
    if server ~= "jdtls" then
        if server ~= "eslint" then
            config = vim.tbl_deep_extend("force", {
                on_attach = common_on_attach,
                capabilities = common_capabilities,
            }, config)
        else
            config = vim.tbl_deep_extend("force", {
                capabilities = common_capabilities,
            }, config)
        end
        vim.lsp.config(server, config)
        vim.lsp.enable(server)
    end
end
