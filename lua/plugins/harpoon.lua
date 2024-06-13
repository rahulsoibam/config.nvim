return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  config = function()
    local harpoon = require('harpoon')
    harpoon:setup()

    -- add to harpoon list ([M]ark to harpoon)
    -- do not use <C-M> as it's the same as <CR> in NeoVim; the enter key will stop working in normal mode
    vim.keymap.set('n', '<leader>m', function()
      harpoon:list():add()
    end, { desc = 'Harpoon: mark buffer' })
    -- toggle [H]arpoon
    vim.keymap.set('n', '<leader>h', function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end, { desc = 'Harpoon: toggle UI' })

    -- keymaps for selection
    vim.keymap.set('n', '<leader>1', function()
      harpoon:list():select(1)
    end, { noremap = true, desc = 'Harpoon: select 1' })
    vim.keymap.set('n', '<leader>2', function()
      harpoon:list():select(2)
    end, { noremap = true, desc = 'Harpoon: select 2' })
    vim.keymap.set('n', '<leader>3', function()
      harpoon:list():select(3)
    end, { noremap = true, desc = 'Harpoon: select 3' })
    vim.keymap.set('n', '<leader>4', function()
      harpoon:list():select(4)
    end, { noremap = true, desc = 'Harpoon: select 4' })
    vim.keymap.set('n', '<leader>5', function()
      harpoon:list():select(5)
    end, { noremap = true, desc = 'Harpoon: select 5' })

    -- keymaps for replace at
    vim.keymap.set('n', '<leader>!', function()
      harpoon:list():replace_at(1)
    end, { noremap = true, desc = 'Harpoon: replace at 1' })
    vim.keymap.set('n', '<leader>@', function()
      harpoon:list():replace_at(2)
    end, { noremap = true, desc = 'Harpoon: replace at 2' })
    vim.keymap.set('n', '<leader>#', function()
      harpoon:list():replace_at(3)
    end, { noremap = true, desc = 'Harpoon: replace at 3' })
    vim.keymap.set('n', '<leader>$', function()
      harpoon:list():replace_at(4)
    end, { noremap = true, desc = 'Harpoon: replace at 4' })
    vim.keymap.set('n', '<leader>%', function()
      harpoon:list():replace_at(5)
    end, { noremap = true, desc = 'Harpoon: replace at 5' })

    -- Set <space>1..<space>5 be my shortcuts to moving to the files
    -- for _, idx in ipairs { 1, 2, 3, 4, 5 } do
    --   vim.keymap.set('n', string.format('<leader>%d', idx), function()
    --     harpoon:list():select(idx)
    --   end)
    -- end

    vim.keymap.set('n', '<C-S-P>', function()
      harpoon:list():prev()
    end)
    vim.keymap.set('n', '<C-S-N>', function()
      harpoon:list():next()
    end)
  end,
}
