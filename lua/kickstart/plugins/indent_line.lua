return {
  { -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help ibl`
    event = { 'BufReadPost', 'BufNewFile' },
    main = 'ibl',
    opts = {
      whitespace = {
        remove_blankline_trail = false,
      },
      indent = { char = '┊' },
    },
  },
}
