return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = 'master',
    lazy = false,
    build = ":TSUpdate"
  },
  {
    'akinsho/bufferline.nvim',
    version = "*",
    dependencies = 'nvim-tree/nvim-web-devicons',
    opts = {
      options = {
        mode = 'tabs',
      },
    },
  },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' }
  },
  {
    "kylechui/nvim-surround",
    version = "^3.0.0", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({
        -- Configuration here, or leave empty to use defaults
      })
    end
  },
  {
    'smoka7/hop.nvim',
    version = "*",
    opts = {
      keys = 'etovxqpdygfblzhckisuran'
    },
    keys = {
      {
        'f', function()
          local hop = require('hop')
          local directions = require('hop.hint').HintDirection
          hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true })
        end
      },
      {
        'F', function()
          local hop = require('hop')
          local directions = require('hop.hint').HintDirection
          hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true })
        end
      },
      {
        't', function()
          local hop = require('hop')
          local directions = require('hop.hint').HintDirection
          hop.hint_patterns({})
        end
      },
      {
        'T', function()
          local hop = require('hop')
          local directions = require('hop.hint').HintDirection
          hop.hint_patterns({ multi_windows = true })
        end
      },
    },
  },
  {
    'nvim-telescope/telescope.nvim', tag = '0.1.8',
    -- or                              , branch = '0.1.x',
    dependencies = { 'nvim-lua/plenary.nvim' },
    keys = {
      {"<localleader>ff", "<cmd>Telescope find_files<cr>"},
      {"<localleader>fg", "<cmd>Telescope live_grep<cr>"},
      {"<localleader>fb", "<cmd>Telescope buffers<cr>"},
      {"<localleader>fh", "<cmd>Telescope help_tags<cr>"},
      {"<localleader>fc", function() require("telescope.builtin").find_files({hidden = true, no_ignore = true}) end},
    },
  },
  {
    'neoclide/coc.nvim',
    branch = 'release',
  },
  {
    'lewis6991/gitsigns.nvim',
  },
}
