return {
  'akinsho/toggleterm.nvim',
  version = '*',
  config = function()
    local toggleterm = require 'toggleterm'

    toggleterm.setup {
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
    }

    function _G.set_terminal_keymaps()
      local opts = { buffer = 0 }
      vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
      -- NOT NEEDED NOW
      -- vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
      -- vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
      -- vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
      -- vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
      -- vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
      -- vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
    end

    -- if you only want these mappings for toggle term use term://*toggleterm#* instead
    vim.cmd 'autocmd! TermOpen term://* lua set_terminal_keymaps()'

    local Terminal = require('toggleterm.terminal').Terminal

    local floating_terminal = Terminal:new {
      -- the following does not work, pass the size in :toggle() as argument instead.
      -- https://github.com/akinsho/toggleterm.nvim/issues/187
      -- size = 20,
      -- cmd = 'lazygit',
      name = 'Floating Terminal',
      hidden = true,
      -- NOTE: big number so that the number won't conflict and mess up the keymaps
      count = 100,
      direction = 'float',
      close_on_exit = true,
      auto_scroll = true,
    }
    -- NOTE: separate terminal for quick use, works in insert, terminal, normal mode
    vim.keymap.set({ 'n', 'i', 't' }, [[<C-\>]], function()
      floating_terminal:toggle()
    end, { desc = 'Floating Terminal' })

    -- [[ Horizontal Terminal ]]
    local horizontal_terminal = Terminal:new {
      name = 'Horizontal Terminal',
      hidden = true,
      count = 101,
      direction = 'horizontal',
      close_on_exit = true,
      auto_scroll = true,
    }
    -- pressing ` would be slightly slower when in terminal but that should be fine.
    vim.keymap.set({ 'n', 't' }, [[`\]], function()
      horizontal_terminal:toggle(25)
    end, { desc = 'Horizontal Terminal' })

    -- [[ Vertical Terminal ]]
    local vertical_terminal = Terminal:new {
      name = 'Vertical Terminal',
      hidden = true,
      count = 9,
      direction = 'vertical',
      close_on_exit = true,
      auto_scroll = true,
    }
    -- pressing 9 would be slightly slower when in terminal but that should be fine.
    vim.keymap.set({ 'n', 't' }, [[9\]], function()
      vertical_terminal:toggle(80)
    end, { desc = 'Vertical Terminal' })
  end,
}
