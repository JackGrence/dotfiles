-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

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
      -- vim.cmd('tabe ' .. vim.fn.stdpath('config') .. '/lua/plugins.lua')
      -- vim.cmd('vsp ' .. os.getenv('MYVIMRC'))
      vim.cmd('tabe ' .. vim.fn.stdpath('config') .. '/lua/plugins/dev.lua')
      vim.cmd('vsp ' .. vim.fn.stdpath('config') .. '/lua/config/lazy.lua')
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

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    -- import your plugins
    { import = "plugins" },
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "habamax" } },
  -- automatically check for plugin updates
  checker = { enabled = true },
})
