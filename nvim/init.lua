-- Original

vim.opt.expandtab = true
vim.opt.signcolumn = 'yes'
vim.opt.termguicolors = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.shiftwidth = 2

function Source_vimrc ()
  vim.ui.input({prompt = 'open config files(y/n)? '}, function(input)
    vim.cmd('source ' ..os.getenv('MYVIMRC'))
    if input == 'y' then
      vim.cmd('tabe ' .. vim.fn.stdpath('config') .. '/lua/plugins.lua')
      vim.cmd('vsp ' .. os.getenv('MYVIMRC'))
      vim.cmd('lcd ' .. vim.fn.stdpath('config'))
    else
      print('')
    end
  end)
end

local nn_opts = { noremap = true, silent = true }

vim.keymap.set('n', '<C-h>', '<Cmd>tabp<CR>', nn_opts)
vim.keymap.set('n', '<C-l>', '<Cmd>tabn<CR>', nn_opts)
vim.keymap.set('n', '<M-s>', '<Cmd>lua Source_vimrc()<CR>', nn_opts)

function BufWipe_and_restart ()
  local buf_name = vim.api.nvim_buf_get_name(0)
  vim.cmd('e /tmp/nvim_wipe_and_restart')
  vim.cmd('bw ' .. buf_name)
  vim.cmd('e ' .. buf_name)
  vim.cmd('bw /tmp/nvim_wipe_and_restart')
end

vim.keymap.set('n', '<leader>bw', function () BufWipe_and_restart() end, nn_opts)



-- Plugin

require('plugins')

vim.cmd[[colorscheme monokai_pro]]
-- vim.api.nvim_set_hl(0, 'TabLineSel', { link = 'Search' })
-- vim.api.nvim_set_hl(0, 'Title', { link = 'Directory' })
vim.keymap.set('n', '<A-8>', '<Cmd>TagbarToggle<CR>', nn_opts)

-- vim.opt.termguicolors = true
-- require('bufferline').setup{}

local navic = require('nvim-navic')
local lsp = require('lsp-zero')
lsp.preset('recommended')

lsp.configure('codeqlls', {
  settings = {
    additional_packs = {
      "~/code/codeql-home/codeql-repo/",
      "~/.codeql/packages/",
      ".",
    }
  },
})

-- attach navic
lsp.on_attach(navic.attach)

lsp.skip_server_setup({'jdtls'})

lsp.setup()

require('lualine').setup {
  -- options = {
  --   -- ... your lualine config
  --   theme = 'monokai-pro'
  --   -- ... your lualine config
  -- },
  sections = {
    lualine_b = {
      'branch',
      'diff',
      {
        'diagnostics',
        symbols = {error = ' ', warn = ' ', info = ' ', hint = ' '}
      },
    },
    lualine_c = {
      { 'filename' },
      {
        'navic',
        color_correction = nil,
        navic_opts = nil,
      },
    }
  }
}

require('fidget').setup {}

-- place this in one of your configuration file(s)
local hop = require('hop')
local directions = require('hop.hint').HintDirection
vim.keymap.set('', 'f', function()
  hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true })
end, {remap=true})
vim.keymap.set('', 'F', function()
  hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true })
end, {remap=true})
vim.keymap.set('', 't', function()
  hop.hint_patterns({ })
end, {remap=true})
vim.keymap.set('', 'T', function()
  hop.hint_patterns({ multi_windows = true })
end, {remap=true})

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
vim.keymap.set('n', '<leader>fc', function() builtin.find_files({hidden = true, no_ignore = true}) end, {})

-- NvimTree
local api = require('nvim-tree.api')
vim.keymap.set('n', '<leader>tt', api.tree.toggle, {})
vim.keymap.set('n', '<leader>to', api.tree.open, {})
vim.keymap.set('n', '<leader>tc', api.tree.close, {})
