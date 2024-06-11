-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- keymap to toggle relative line number
vim.keymap.set('n', '<leader>n', function()
  if vim.o.relativenumber == true then
    vim.o.relativenumber = false
  else
    vim.o.relativenumber = true
  end
end, { desc = 'Toggle relative line numbers' })

-- source current file
vim.keymap.set('n', '<leader><leader>', function()
  vim.cmd 'so'
end)

-- move visual mode selected block. also autoindents inside blocks
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

-- J takes the line below you and appends it to the current line. This allows the cursor to stay at the same place instead of way over at the end
vim.keymap.set('n', 'J', 'mzJ`z')

-- allow Ctrl-d and Ctrl-u, half page jumping to just keep cursor in the middle
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')

-- allow search terms to stay in the middle
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')

-- Delete the selected text without affecting any registers (using "_d)
-- Paste the previously deleted or yanked text before the cursor position (P).
vim.keymap.set('x', '<leader>p', [["_dP]])

-- in normal and visual mode <leader>y sends the yanked text to system clipboard
vim.keymap.set({ 'n', 'v' }, '<leader>y', [["+y]])
vim.keymap.set({ 'n', 'v' }, '<leader>Y', [["+Y]])

-- do not add deleted text to register
vim.keymap.set({ 'n', 'v' }, '<leader>d', [["_d]])

vim.keymap.set('n', 'Q', '<nop>')

-- run the tmux-sessionizer script
vim.keymap.set('n', '<C-f>', '<cmd>silent !tmux neww tmux-sessionizer<CR>')

-- quickfix list keymaps
vim.keymap.set('n', '<C-k>', '<cmd>cnext<CR>zz')
vim.keymap.set('n', '<C-j>', '<cmd>cprev<CR>zz')
vim.keymap.set('n', '<leader>k', '<cmd>lnext<CR>zz')
vim.keymap.set('n', '<leader>j', '<cmd>lprev<CR>zz')

-- make script executable
vim.keymap.set('n', '<leader>x', '<cmd>!chmod +x %<CR>', { silent = true })

-- remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- delete single character without copying into register
vim.keymap.set('n', 'x', '"_x')

-- keymap to add current date and time, useful for logging.
vim.keymap.set('n', '<leader>da', function()
  -- Get the current date and time with the desired format
  local datetime = os.date '%A, %d %B, %Y at %H:%M:%S'
  -- Put the datetime string in the current buffer
  vim.api.nvim_put({ tostring(datetime) }, 'l', true, true)
end, { desc = 'Insert current date and time' })

-- TIP: Disable arrow keys in normal mode
vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')
