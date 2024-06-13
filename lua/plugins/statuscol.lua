return {
  'luukvbaal/statuscol.nvim',
  config = function()
    local builtin = require 'statuscol.builtin'
    require('statuscol').setup {

      relculright = true,
      segments = {
        { text = { '%s' }, click = 'v:lua.ScSa' },
        {
          text = { builtin.lnumfunc, ' ' },
          condition = { true, builtin.not_empty },
          click = 'v:lua.ScLa',
        },
        -- this is one that works for me. I turned it off because it looks zanky
        -- { text = { builtin.foldfunc, ' ' }, click = 'v:lua.ScFa' },
        -- this is the default
        -- { text = { '%C' }, click = 'v:lua.ScFa' },

        -- NOTE: for just gitsings, you could do  this. Found people complaining that gitsigns went away with this plugin
        -- {
        --   sign = { namespace = { 'gitsigns' }, name = { '.*' }, maxwidth = 1, colwidth = 1, auto = false },
        --   click = 'v:lua.ScSa',
        -- },
      },
    }
  end,
}
