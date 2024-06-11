return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  config = function()
    local harpoon = require 'harpoon'
    harpoon:setup()

    -- add to harpoon list (mark to [H]arpoon)
    vim.keymap.set('n', '<C-h>', function()
      harpoon:list():add()
    end)
    -- toggle [H]arpoon
    vim.keymap.set('n', '<leader>h', function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end)

    -- keymaps for selection
    vim.keymap.set('n', '<C-j>', function()
      harpoon:list():select(1)
    end)
    vim.keymap.set('n', '<C-k>', function()
      harpoon:list():select(2)
    end)
    vim.keymap.set('n', '<C-l>', function()
      harpoon:list():select(3)
    end)
    vim.keymap.set('n', '<C-;>', function()
      harpoon:list():select(4)
    end)

    -- keymaps for replace at
    vim.keymap.set('n', '<C-S-J>', function()
      harpoon:list():replace_at(1)
    end)
    vim.keymap.set('n', '<C-S-K>', function()
      harpoon:list():replace_at(2)
    end)
    vim.keymap.set('n', '<C-S-L>', function()
      harpoon:list():replace_at(3)
    end)
    vim.keymap.set('n', '<C-S-:>', function()
      harpoon:list():replace_at(4)
    end)

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
