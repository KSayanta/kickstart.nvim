-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
---@diagnostic disable unused-local
return {
  {
    'kylechui/nvim-surround',
    version = '*', -- Use for stability; omit to use `main` branch for the latest features
    event = 'VeryLazy',
    config = function()
      require('nvim-surround').setup {
        -- Configuration here, or leave empty to use defaults
      }
    end,
  },

  { -- Not UFO in the sky, but an ultra fold in Neovim.
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

  -- { -- Neovim statusline
  --   'nvim-lualine/lualine.nvim',
  --   dependencies = { 'nvim-tree/nvim-web-devicons' },
  --   config = function()
  --     require('lualine').setup {
  --       options = {
  --         theme = 'dracula',
  --       },
  --     }
  --   end,
  -- },

  { -- Codium integration
    'Exafunction/codeium.vim',
    event = 'BufEnter',
  },

  { -- Automated session manager
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

  { -- Tab styling
    'akinsho/bufferline.nvim',
    version = '*',
    dependencies = 'nvim-tree/nvim-web-devicons',
    opts = {
      options = {
        mode = 'tabs',
        separator_style = 'slant',
      },
    },
  },

  { -- dress default vim.ui
    'stevearc/dressing.nvim',
    event = 'VeryLazy',
    opts = { -- your config here
    },
  },

  { -- Maximizes and restores the current window size
    'szw/vim-maximizer',
    event = 'VeryLazy',
    config = function()
      vim.keymap.set('n', '<leader>wm', '<cmd>MaximizerToggle<CR>', { desc = '[W]indow [M]Maximize ' })
    end,
  },

  { -- Plugin to quickly replace and exchange text
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

  { -- trouble.nvim
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
    },
    opts = {},
  },
}
