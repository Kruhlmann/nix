local vim = vim
local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }
vim.loader.enable()
vim.g.mapleader = " "
vim.g.maplocalleader = " "
map("n", "<Space>", "<Nop>", opts)
map('n', '<Up>', '<Nop>', { noremap = true })
map('n', '<Down>', '<Nop>', { noremap = true })
map('n', '<Left>', '<Nop>', { noremap = true })
map('n', '<Right>', '<Nop>', { noremap = true })
map('i', '<Up>', '<Nop>', { noremap = true })
map('i', '<Down>', '<Nop>', { noremap = true })
map('i', '<Left>', '<Nop>', { noremap = true })
map('i', '<Right>', '<Nop>', { noremap = true })
map('n', 'n', 'nzzzv', { noremap = false })
map('n', 'N', 'Nzzzv', { noremap = false })
map('n', '*', '*<C-O>', { noremap = true })
map('n', ';', ':', { noremap = true })
map('n', 'k', "v:count == 0 ? 'gk' : 'k'", { noremap = true, expr = true, silent = true })
map('n', 'j', "v:count == 0 ? 'gj' : 'j'", { noremap = true, expr = true, silent = true })
map('n', 'Y', 'y$', { noremap = true })
map("v", "<leader>/", "gc", { noremap = false })
map("n", "<leader>/", "gcc", { noremap = false })
map('n', '<leader>,', '<cmd>vsplit<CR>', opts)
map('n', '<leader>.', '<cmd>split<CR>', opts)

vim.api.nvim_create_autocmd({ "VimEnter" }, {
    callback = function()
        vim.cmd "hi link illuminatedWord LspReferenceText"
    end,
})

vim.api.nvim_create_autocmd({ "TextYankPost" }, {
    callback = function()
        vim.highlight.on_yank { higroup = "Visual", timeout = 200 }
    end,
})

vim.api.nvim_exec([[ autocmd BufNewFile,BufRead *.sol set filetype=solidity ]], false)
vim.api.nvim_exec([[ autocmd BufNewFile,BufRead *.alc set filetype=alchemy ]], false)

vim.api.nvim_create_autocmd({ "VimResized" }, {
    callback = function()
        vim.cmd "tabdo wincmd ="
    end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = { "qf", "help", "man", "lspinfo", "spectre_panel", "lir" },
    callback = function()
        vim.cmd [[
      nnoremap <silent> <buffer> q :close<CR>
      set nobuflisted
    ]]
    end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = { "gitcommit", "markdown" },
    callback = function()
        vim.opt_local.wrap = true
        vim.opt_local.spell = true
    end,
})

function add_banner_comment()
    local filepath = vim.fn.expand('%:p')
    if not filepath:match('^' .. vim.fn.expand('~/doc/src/code.siemens.com')) then
        return
    end

    local current_year = os.date("%Y")
    local banner_lines = { "Copyright (c) Siemens Mobility A/S " ..
    current_year .. ", All Rights Reserved - CONFIDENTIAL", }
    local current_lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
    for _, line in ipairs(current_lines) do
        if line:find("CONFIDENTIAL") then
            return
        end
    end

    local insertion_point = 0
    if #current_lines > 0 and current_lines[1]:find("^#!") then
        insertion_point = 1
    end

    vim.api.nvim_buf_set_lines(0, insertion_point, insertion_point, false, banner_lines)
    local end_line = insertion_point + #banner_lines
    vim.api.nvim_input(string.format(":%d,%dCommentary<cr>", insertion_point + 1, end_line))
end

vim.api.nvim_exec([[
  augroup add_banner
    autocmd!
    autocmd FileType * lua add_banner_comment()
  augroup END
]], false)

local home_directory = vim.fn.expand('~')

vim.o.inccommand = "nosplit"
vim.o.shell = "zsh"
vim.o.number = true
vim.o.cursorline = true
vim.o.wrap = true
vim.o.syntax = "on"
vim.o.relativenumber = true
vim.o.hlsearch = true
vim.o.hidden = true
vim.o.mouse = "a"
vim.o.autoindent = true
vim.o.clipboard = "unnamedplus"
vim.o.history = 1000
vim.o.background = "dark"
vim.o.ruler = true
vim.o.smarttab = true
vim.o.expandtab = true
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.termguicolors = true
vim.o.updatetime = 250
vim.o.ffs = "unix,dos"
vim.o.cmdheight = 1
vim.o.showmatch = true
vim.o.shortmess = vim.o.shortmess .. "c"
vim.o.signcolumn = "yes"
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.termguicolors = true
vim.o.completeopt = "menuone,noinsert,noselect"
vim.o.undodir = home_directory .. "/.cache/nvim/undo/"
vim.o.backupdir = home_directory .. "/.cache/nvim/backup/"
vim.o.directory = home_directory .. "/.cache/nvim/swap/"
vim.o.undofile = true
vim.o.backup = true
vim.o.swapfile = false
vim.g.indent_blankline_char = "┊"
vim.g.indent_blankline_filetype_exclude = { 'help', 'packer' }
vim.g.indent_blankline_buftype_exclude = { 'terminal', 'nofile' }
vim.g.indent_blankline_char_highlight = 'LineNr'
vim.g.page_icon_pipe = '|'
vim.g.page_icon_redirect = '>'
vim.g.page_icon_instance = '$'
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors = true
