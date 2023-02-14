-- Original

vim.opt.expandtab = true
vim.opt.signcolumn = 'yes'
vim.opt.termguicolors = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.shiftwidth = 2

local nn_opts = { noremap = true, silent = true }
vim.keymap.set('n', '<C-h>', '<Cmd>tabp<CR>', nn_opts)
vim.keymap.set('n', '<C-l>', '<Cmd>tabn<CR>', nn_opts)

-- Plugin

require('plugins')

vim.cmd[[colorscheme monokaipro]]
vim.keymap.set('n', '<A-8>', '<Cmd>TagbarToggle<CR>', nn_opts)


local lsp = require('lsp-zero')
lsp.preset('recommended')

lsp.setup()

require('lualine').setup {
  options = {
    -- ... your lualine config
    theme = 'monokaipro'
    -- ... your lualine config
  }
}
