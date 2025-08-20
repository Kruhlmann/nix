vim.o.completeopt = "menuone,noselect,preview"

local cmp = require("cmp")
local lspkind = require("lspkind")
cmp.setup({
    preselect = cmp.PreselectMode.None,
    snippet = {
        expand = function(args)
            require("luasnip").lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ["<C-p>"] = cmp.mapping.select_prev_item(),
        ["<C-n>"] = cmp.mapping.select_next_item(),
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.close(),
        ["<CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Insert,
            select = false,
        }),
        ["<Right>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        }),
    }),
    sources = {
        { name = "nvim_lua" },
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "buffer" },
        { name = "path" },
    },
    formatting = {
        format = function(_, vim_item)
            local kind = vim_item.kind or ""
            local icon = lspkind.presets.default[kind] or ""
            vim_item.kind = icon .. " " .. kind
            return vim_item
        end,
    },
})

-- Snippets
require("luasnip/loaders/from_vscode").lazy_load()

-- Autopairs
local cmp_autopairs = require("nvim-autopairs.completion.cmp")
require("nvim-autopairs").setup({ check_ts = true })
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({}))
