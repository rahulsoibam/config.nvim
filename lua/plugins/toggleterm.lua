return {
  'akinsho/toggleterm.nvim',
  version = '*',
  config = function()
    local toggleterm = require('toggleterm')

    toggleterm.setup({
      size = 25,
      -- toggle last opened terminal
      -- if you prefix the mapping with a number that particular terminal will be opened.
      open_mapping = [[\]],
      -- allow toggle in insert mode, set normal mode then toggles
      insert_mappings = false,
      terminal_mappings = false,
      hide_numbers = true,
      shade_filetyles = {},
      shade_terminals = true,
      shading_factor = 2,
      start_in_insert = true,
      persist_size = true,
      direction = 'float',
      close_on_exit = true,
      shell = vim.o.shell,
      float_opts = {
        border = 'curved',
        winblend = 0,
        highlights = {
          border = 'Normal',
          background = 'Normal',
        },
      },
    })

    local Terminal = require('toggleterm.terminal').Terminal

    local floating_terminal = Terminal:new({
      -- the following does not work, pass the size in :toggle() as argument instead.
      -- https://github.com/akinsho/toggleterm.nvim/issues/187
      -- size = 20,
      -- cmd = 'lazygit',
      -- does not work with oil
      -- dir = '%:p:h',
      name = 'Floating Terminal',
      hidden = true,
      -- NOTE: big number so that the number won't conflict and mess up the keymaps
      count = 100,
      direction = 'float',
      close_on_exit = true,
      auto_scroll = true,
    })
    -- NOTE: separate terminal for quick use, works in insert, terminal, normal mode
    vim.keymap.set({ 'n', 'i', 't' }, [[<C-\>]], function()
      floating_terminal:toggle()
    end, { desc = 'Floating Terminal' })

    -- [[ Horizontal Terminal ]]
    local horizontal_terminal = Terminal:new({
      name = 'Horizontal Terminal',
      hidden = true,
      count = 101,
      direction = 'horizontal',
      close_on_exit = true,
      auto_scroll = true,
    })
    -- pressing ` would be slightly slower when in terminal but that should be fine.
    vim.keymap.set({ 'n', 't' }, [[`\]], function()
      horizontal_terminal:toggle(25)
    end, { desc = 'Horizontal Terminal' })

    -- [[ Vertical Terminal ]]
    local vertical_terminal = Terminal:new({
      name = 'Vertical Terminal',
      hidden = true,
      count = 9,
      direction = 'vertical',
      close_on_exit = true,
      auto_scroll = true,
    })
    -- pressing 9 would be slightly slower when in terminal but that should be fine.
    vim.keymap.set({ 'n', 't' }, [[9\]], function()
      vertical_terminal:toggle(80)
    end, { desc = 'Vertical Terminal' })

    vim.keymap.set('n', [[<M-\>]], '<cmd>ToggleTerm dir=%:p:h<CR>', { desc = 'Open terminal in current working dir' })
  end,
}
