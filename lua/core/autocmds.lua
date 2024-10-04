-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- save view folds when leaving buffer
vim.api.nvim_create_autocmd({ 'BufWinLeave' }, {
  pattern = { '*.*' },
  group = vim.api.nvim_create_augroup('remember_folds', { clear = false }),
  desc = 'save view (folds), when closing file',
  command = 'mkview',
})

-- load view folds when opening file
vim.api.nvim_create_autocmd({ 'BufWinEnter' }, {
  pattern = { '*.*' },
  group = vim.api.nvim_create_augroup('remember_folds', { clear = false }),
  desc = 'load view (folds), when opening file',
  command = 'silent! loadview',
})
