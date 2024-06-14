return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    -- [[ Returns LSPs attached to current buffer ]]
    local lsp_names = function()
      local bufnr = 0 -- 0 means current buffer
      local clients = vim.lsp.get_clients({ bufnr = bufnr })
      if next(clients) == nil then
        return ''
      end

      local names = {}
      for _, client in ipairs(clients) do
        table.insert(names, client.name)
      end

      return table.concat(names, ',')
    end

    -- [[ Get filename, start from ~ if inside home directory, otherwise absolute path ]]
    local filename = function()
      local filename = vim.fn.expand('%:p')
      local home = vim.fn.expand('$HOME')
      -- local oil_pattern = '^oil://'

      -- Don't show anything for oil:// buffers
      -- if filename:match(oil_pattern) then
      --   return ''
      -- end

      -- Show relative path from home if in home folder, otherwise show full path
      if filename:sub(1, #home) == home then
        filename = '~' .. filename:sub(#home + 1)
      end

      return filename
    end

    require('lualine').setup({
      options = {
        icons_enabled = true,
        theme = 'tokyonight',
        -- component_separators = { left = '', right = '' },
        -- section_separators = { left = '\\', right = '\\' },
        component_separators = '',
        section_separators = { left = '', right = '' },
        disabled_filetypes = {
          statusline = {},
          winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = true,
        globalstatus = true,
        refresh = {
          statusline = 1000,
          tabline = 1000,
          winbar = 1000,
        },
      },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = { { 'branch', icon = '' }, 'diff' },
        lualine_c = {
          'diagnostics',
          {
            filename,
            color = { fg = '#565f89', gui = 'None' },
            -- cond = function() end
          },
          -- {
          --   function()
          --     local gitsigns = vim.b.gitsigns_status_dict
          --     if gitsigns then
          --       local current_line = vim.fn.line('.')
          --       local blame_info = vim.fn.system(
          --         'git -C '
          --           .. vim.fn.shellescape(gitsigns.root)
          --           .. ' blame -L '
          --           .. current_line
          --           .. ','
          --           .. current_line
          --           .. ' --porcelain -- '
          --           .. vim.fn.shellescape(vim.fn.expand('%:p'))
          --       )
          --
          --       local author = blame_info:match('author (.-)\n')
          --       local summary = blame_info:match('summary (.-)\n')
          --
          --       if author and summary then
          --         local blame_text = string.format('  %s: %s', author, summary)
          --         -- Truncate if too long
          --         local max_len = 50
          --         if #blame_text > max_len then
          --           blame_text = blame_text:sub(1, max_len - 3) .. '...'
          --         end
          --
          --         return blame_text
          --       end
          --     end
          --     return ''
          --   end,
          -- },
        },
        -- lualine_c = { { 'filename', path = 2 } },
        lualine_x = {
          {
            lsp_names,
            color = function()
              return { fg = vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID('Function')), 'fg#') }
            end,
            -- icon = '  LSP:',
            -- icon = '󱞒',
            icon = '󰧑 LSP:',
          },
          -- 'diagnostics',
          -- 'encoding',
          -- 'filetype',
        },
        lualine_y = { 'filetype' },
        lualine_z = {
          'location',
          'progress',
          -- 'encoding',
          -- 'filetype',
        },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { 'filename' },
        lualine_x = { 'location' },
        lualine_y = {},
        lualine_z = {},
      },
      tabline = {},
      winbar = {},
      inactive_winbar = {},
      extensions = {},
    })
  end,
}
