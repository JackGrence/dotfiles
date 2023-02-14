-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- Colorscheme
  use 'joshdick/onedark.vim'
  use 'https://gitlab.com/__tpb/monokai-pro.nvim'
  -- LSP
  use {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v1.x',
    requires = {
      -- LSP Support
      {'neovim/nvim-lspconfig'},
      {'williamboman/mason.nvim'},
      {'williamboman/mason-lspconfig.nvim'},

      -- Autocompletion
      {'hrsh7th/nvim-cmp'},
      {'hrsh7th/cmp-buffer'},
      {'hrsh7th/cmp-path'},
      {'saadparwaiz1/cmp_luasnip'},
      {'hrsh7th/cmp-nvim-lsp'},
      {'hrsh7th/cmp-nvim-lua'},

      -- Snippets
      {'L3MON4D3/LuaSnip'},
      {'rafamadriz/friendly-snippets'},
    }
  }
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  }

  use {
    "SmiteshP/nvim-navic",
    requires = "neovim/nvim-lspconfig"
  }

  use {
    "pwntester/codeql.nvim",
    requires = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-lua/telescope.nvim",
      "kyazdani42/nvim-web-devicons",
      {
        's1n7ax/nvim-window-picker',
        tag = 'v1.*',
        config = function()
          require'window-picker'.setup({
            autoselect_one = true,
            include_current = true,
            filter_rules = {
              bo = {
                filetype = {
                  "codeql_panel",
                  "codeql_explorer",
                  "qf",
                  "TelescopePrompt",
                  "TelescopeResults",
                  "notify",
                  "NvimTree",
                  "neo-tree",
                },
                buftype = { 'terminal' },
              },
            },
            current_win_hl_color = '#4f6fff',
            other_win_hl_color = '#44cc41',
          })
        end,
      }
    },
    config = function()
      require("codeql").setup {
        additional_packs = {
          "~/code/codeql-home/codeql-repo/",
          ".",
        },
        panel = {
          group_by = "sink",
          show_filename = true,
          long_filename = false,
          context_lines = 3,
        }
      }
    end
  }

  use 'preservim/tagbar'

  use 'j-hui/fidget.nvim'

end)
