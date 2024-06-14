return { -- Collection of various small independent plugins/modules
  'echasnovski/mini.nvim',
  config = function()
    -- Better Around/Inside textobjects
    --
    -- Examples:
    --  - va)  - [V]isually select [A]round [)]paren
    --  - yinq - [Y]ank [I]nside [N]ext [']quote
    --  - ci'  - [C]hange [I]nside [']quote
    require('mini.ai').setup({ n_lines = 500 })

    -- Add/delete/replace surroundings (brackets, quotes, etc.)
    --
    -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
    -- - sd'   - [S]urround [D]elete [']quotes
    -- - sr)'  - [S]urround [R]eplace [)] [']
    require('mini.surround').setup()

    require('mini.comment').setup()

    require('mini.misc').setup()
    -- [[ This works, when opening a terminal, it opens the parent dir of the file ]]
    -- [[ BUT IT MESSES UP THE DEFAULT TELESCOPE FILE PICKER THAT I USE ]]
    -- local dir = function()
    --   local current_path = vim.fn.expand('%:p')
    --
    --   -- 1. Check if the current path is a directory
    --   if vim.fn.isdirectory(current_path) == 1 then
    --     return current_path
    --   end
    --
    --   -- 2. Check if it starts with oil://
    --   if current_path:match('^oil://') then
    --     return current_path:gsub('^oil://', '')
    --   end
    --
    --   -- 3. Check if it is a file
    --   if vim.fn.filereadable(current_path) == 1 then
    --     local file_dir = vim.fn.fnamemodify(current_path, ':h')
    --     return vim.fn.fnamemodify(file_dir, ':h')
    --   end
    --
    --   -- 4. For everything else, use the default behavior
    --   return vim.fn.getcwd()
    -- end
    --
    -- require('mini.misc').setup_auto_root(dir)
    require('mini.misc').setup_restore_cursor({ center = true, ignore_filetype = { 'gitrebase', 'gitcommit' } })

    -- require('mini.files').setup()

    -- Simple and easy statusline.
    --  You could remove this setup call if you don't like it,
    --  and try some other statusline plugin
    -- local statusline = require 'mini.statusline'
    -- -- set use_icons to true if you have a Nerd Font
    -- statusline.setup { use_icons = vim.g.have_nerd_font }
    --
    -- -- You can configure sections in the statusline by overriding their
    -- -- default behavior. For example, here we set the section for
    -- -- cursor location to LINE:COLUMN
    -- ---@diagnostic disable-next-line: duplicate-set-field
    -- statusline.section_location = function()
    --   return '%2l:%-2v'
    -- end

    -- ... and there is more!
    --  Check out: https://github.com/echasnovski/mini.nvim
  end,
}
