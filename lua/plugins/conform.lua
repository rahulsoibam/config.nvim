return { -- Autoformat
  'stevearc/conform.nvim',
  dependencies = {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
  },
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },
  config = function()
    local ensure_installed = {
      'stylua',
      'goimports',
      'prettierd',
      'prettier',
      -- 'goimports-reviser',
    }

    require('mason-tool-installer').setup({
      ensure_installed = ensure_installed,
    })

    local conform = require('conform')

    conform.setup({
      notify_on_error = true,
      formatters_by_ft = {
        lua = { 'stylua' },
        go = { 'goimports' },
        typescript = { 'prettierd', 'prettier', stop_after_first = true },
        typescriptreact = { 'prettierd', 'prettier', stop_after_first = true },
        javascript = { 'prettierd', 'prettier', stop_after_first = true },
        javascriptreact = { 'prettierd', 'prettier', stop_after_first = true },
        json = { 'prettierd', 'prettier', stop_after_first = true },
        html = { 'prettierd', 'prettier', stop_after_first = true },
        css = { 'prettierd', 'prettier', stop_after_first = true },
      },

      format_on_save = function(bufnr)
        -- Disable "format_on_save lsp_fallback" for languages that don't
        -- have a well standardized coding style. You can add additional
        -- languages here or re-enable it for the disabled ones.
        local disable_filetypes = { c = true, cpp = true }
        return {
          timeout_ms = 500,
          lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
        }
      end,
    })
  end,
  keys = {
    {
      '<leader>f',
      function()
        require('conform').format({ async = true, lsp_format = 'fallback' })
      end,
      mode = '',
      desc = '[F]ormat buffer',
    },
  },
}
