---@diagnostic disable unused-local

return {
  { -- NOTE: Nvim Surround
    'kylechui/nvim-surround',
    version = '*', -- Use for stability; omit to use `main` branch for the latest features
    event = 'VeryLazy',
    config = function()
      require('nvim-surround').setup {
        -- Configuration here, or leave empty to use defaults
      }
    end,
  },

  { -- NOTE: Nvim UFO Code folding
    'kevinhwang91/nvim-ufo',
    dependencies = {
      'kevinhwang91/promise-async',
      {
        'luukvbaal/statuscol.nvim',
        config = function()
          local builtin = require 'statuscol.builtin'
          require('statuscol').setup {
            relculright = true,
            segments = {
              { text = { builtin.foldfunc }, click = 'v:lua.ScFa' },
              { text = { '%s' }, click = 'v:lua.ScSa' },
              { text = { builtin.lnumfunc, ' ' }, click = 'v:lua.ScLa' },
            },
          }
        end,
      },
    },
    init = function()
      vim.o.foldenable = true
      vim.o.foldcolumn = '1'
      vim.o.foldlevel = 99
      vim.o.foldlevelstart = 99
      vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
    end,
    event = 'BufReadPost',
    open_fold_h1_timeout = 100,
    disabled = { 'org' }, -- disabled in file explorer
    opts = {
      provider_selector = function(bufnr, filetype, buftype)
        return { 'lsp', 'indent' }
      end,
    },
  },

  { -- NOTE: Nvim Statusline
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('lualine').setup {
        options = {
          theme = 'auto',
        },
        sections = {
          lualine_x = { 'encoding', 'fileformat', 'filetype' },
        },
      }
    end,
  },

  { -- NOTE: Automated session manager
    'rmagatti/auto-session',
    lazy = false,
    keys = {
      { '<leader>wR', '<cmd>SessionSearch<cr>', desc = 'Session restore' },
      { '<leader>wS', '<cmd>SessionSave<cr>', desc = 'Session save for cwd' },
    },

    ---enables autocomplete for opts
    ---@module 'auto-session'
    ---@type AutoSession.Config
    opts = {
      auto_restore = false,
      auto_save = true,
      allowed_dirs = { '~/Projects/' },
    },
  },

  { -- NOTE: Tab styling
    'akinsho/bufferline.nvim',
    version = '*',
    dependencies = 'nvim-tree/nvim-web-devicons',
    opts = {
      options = {
        mode = 'tabs',
        separator_style = 'thick',
      },
    },
  },

  { -- NOTE: Nvim UI
    'stevearc/dressing.nvim',
    event = 'VeryLazy',
    opts = { -- your config here
    },
  },

  { -- NOTE: Window maximizer
    'szw/vim-maximizer',
    event = 'VeryLazy',
    config = function()
      vim.keymap.set('n', '<leader>wm', '<cmd>MaximizerToggle<CR>', { desc = '[W]indow [M]Maximize ' })
    end,
  },

  { -- NOTE: Substitute
    'gbprod/substitute.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      require('substitute').setup()
      vim.keymap.set('n', 's', require('substitute').operator, { desc = '[Substitute] with motion' })
      vim.keymap.set('n', 'ss', require('substitute').line, { desc = '[Substitute] line under cursor' })
      vim.keymap.set('n', 'S', require('substitute').eol, { desc = '[Substitute] to end of line' })
      vim.keymap.set('x', 's', require('substitute').visual, { desc = '[Substitute] visual selection' })
    end,
  },

  { -- NOTE: trouble.nvim
    'folke/trouble.nvim',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
      'folke/todo-comments.nvim',
    },
    cmd = 'Trouble',
    keys = {
      {
        '<leader>xx',
        '<cmd>Trouble diagnostics toggle<cr>',
        desc = 'Diagnostics (Trouble)',
      },
      {
        '<leader>xX',
        '<cmd>Trouble diagnostics toggle filter.buf=0<cr>',
        desc = 'Buffer Diagnostics (Trouble)',
      },
      {
        '<leader>xs',
        '<cmd>Trouble symbols toggle focus=false<cr>',
        desc = 'Symbols (Trouble)',
      },
      {
        '<leader>xl',
        '<cmd>Trouble lsp toggle focus=false win.position=right<cr>',
        desc = 'LSP Definitions / references / ... (Trouble)',
      },
      {
        '<leader>xL',
        '<cmd>Trouble loclist toggle<cr>',
        desc = 'Location List (Trouble)',
      },
      {
        '<leader>xQ',
        '<cmd>Trouble qflist toggle<cr>',
        desc = 'Quickfix List (Trouble)',
      },
      {
        '<leader>xt',
        '<cmd>Trouble todo toggle<cr>',
        desc = 'Toggle Trouble',
      },
    },
    opts = {},
  },

  { -- NOTE: Live server
    'barrett-ruth/live-server.nvim',
    cmd = { 'LiveServerStart', 'LiveServerStop' },
    config = true,
    keys = {
      { '<leader>gl', '<cmd>LiveServerStart<cr>', desc = 'Start live server' },
      { '<leader>gL', '<cmd>LiveServerStop<cr>', desc = 'Stop live server' },
    },
    opts = {
      args = (function()
        -- Get host ip address for live server
        -- Require inetutils installed for hostname command
        local host = '--host=' .. vim.system({ 'hostname', '-I' }, { text = true }):wait().stdout
        return {
          '--port=5555',
          host,
          '--no-browser',
          '--quiet',
        }
      end)(),
    },
  },

  { -- NOTE: Dashboard
    'goolord/alpha-nvim',
    -- dependencies = { 'echasnovski/mini.icons' },
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      local theta = require 'alpha.themes.theta'
      -- available: devicons, mini, default is mini
      -- if provider not loaded and enabled is true, it will try to use another provider
      theta.file_icons.provider = 'devicons'
      theta.header.val = {
        [[                                                                       ]],
        [[                                                                       ]],
        [[                                                                       ]],
        [[                                                                       ]],
        [[                                                                     ]],
        [[       ████ ██████           █████      ██                     ]],
        [[      ███████████             █████                             ]],
        [[      █████████ ███████████████████ ███   ███████████   ]],
        [[     █████████  ███    █████████████ █████ ██████████████   ]],
        [[    █████████ ██████████ █████████ █████ █████ ████ █████   ]],
        [[  ███████████ ███    ███ █████████ █████ █████ ████ █████  ]],
        [[ ██████  █████████████████████ ████ █████ █████ ████ ██████ ]],
        [[                                                                       ]],
        [[                                                                       ]],
        [[                                                                       ]],
      }
      require('alpha').setup(theta.config)
    end,
  },

  { -- NOTE: yazi
    ---@type LazySpec
    'mikavilpas/yazi.nvim',
    event = 'VeryLazy',
    dependencies = {
      'folke/snacks.nvim',
    },
    keys = {
      {
        '<leader>O',
        mode = { 'n', 'v' },
        '<cmd>Yazi<cr>',
        desc = 'Yazi: Open yazi at the current file',
      },
      {
        '<leader>wo',
        '<cmd>Yazi cwd<cr>',
        desc = 'Yazi: [W]orkspace [O]pen cwd',
      },
      {
        '<leader>o',
        '<cmd>Yazi toggle<cr>',
        desc = 'Yazi: Toggle the last yazi session',
      },
    },
    ---@type YaziConfig | {}
    opts = {
      -- if you want to open yazi instead of netrw, see below for more info
      open_for_directories = false,
      keymaps = {
        show_help = '<f1>',
      },
    },
    -- 👇 if you use `open_for_directories=true`, this is recommended
    init = function()
      -- More details: https://github.com/mikavilpas/yazi.nvim/issues/802
      -- vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1
    end,
  },

  { -- NOTE: Transparent nvim
    'xiyaowong/transparent.nvim',

    config = function()
      require('transparent').setup {
        -- config here
      }
      require('transparent').clear_prefix 'BufferLine'
      -- require('transparent').clear_prefix 'NeoTree'
      -- require('transparent').clear_prefix 'lualine'

      vim.keymap.set('n', '<leader>tt', '<Cmd>TransparentToggle<CR>', { desc = '[T]oggle [T]ransparent UI' })
    end,
  },
}
