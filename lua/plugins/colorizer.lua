return {
  -- NORCALLI DOES NOT WORK PROPERLY. WASTED A LOT OF TIME ON THIS. F**K.
  -- 'norcalli/nvim-colorizer.lua',
  'NvChad/nvim-colorizer.lua',
  event = { 'BufReadPre', 'BufNewFile' },
  config = function()
    require('colorizer').setup({
      filetypes = {
        css = { rgb_fn = true },
        'javascript',
        'javascriptreact',
        'typescript',
        'typescriptreact',
        html = { mode = 'foreground' },
      },
      user_default_options = { mode = 'background' },
    })
  end,
}
