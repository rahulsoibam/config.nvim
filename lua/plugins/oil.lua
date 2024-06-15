return {
  'stevearc/oil.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    require('oil').setup({
      default_file_explorer = true,
      delete_to_trash = true,
      skip_confirm_for_simple_edits = true,
      columns = { 'icon' },
      keymaps = {
        ['<C-h>'] = false,
        ['<M-h>'] = 'actions.select_split',
      },
      constrain_cursor = 'editable',
      view_options = {
        show_hidden = true,
        natural_order = true,
        is_always_hidden = function(name, _)
          return name == '.git' -- or name == '..'
        end,
      },
      win_options = {
        wrap = true,
      },
    })

    -- Open parent directory in current window
    vim.keymap.set('n', '-', '<CMD>Oil<CR>', { desc = 'Open parent directory' })

    -- Open parent directory in floating window
    vim.keymap.set('n', '<leader>-', require('oil').toggle_float, { desc = 'Open parent directory in floating window' })
  end,
}
