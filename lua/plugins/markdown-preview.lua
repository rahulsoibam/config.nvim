return {
  'iamcco/markdown-preview.nvim',
  cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
  ft = { 'markdown' },
  build = function()
    vim.fn['mkdp#util#install']()
  end,
  config = function()
    vim.keymap.set('n', '<leader>mp', '<cmd>MarkdownPreviewToggle<CR>', { desc = '[M]arkdown [P]review toggle' })
  end,
}
