return { -- Autoformat
  'stevearc/conform.nvim',
  lazy = false,
  dependencies = {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
  },
  config = function()
    local ensure_installed = {
      'stylua',
      'goimports',
      -- 'gofumpt',
      -- 'goimports-reviser',
    }

    require('mason-tool-installer').setup {
      ensure_installed = ensure_installed,
    }

    local conform = require 'conform'

    conform.setup {
      notify_on_error = true,
      formatters_by_ft = {
        lua = { 'stylua' },
        go = { 'goimports' },
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
    }
  end,
  keys = {
    {
      '<leader>f',
      function()
        require('conform').format { async = true, lsp_fallback = true }
      end,
      mode = '',
      desc = '[F]ormat buffer',
    },
  },
}
