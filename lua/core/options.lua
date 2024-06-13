-- [[ Setting options ]]
-- See `:help vim.opt`
-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`

-- line numbers
vim.opt.relativenumber = true -- show relative line numbers
vim.opt.number = true -- shows absolute line number on cursor line (when relative number is on)

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = 'a'

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.opt.clipboard = 'unnamedplus'

-- Enable break indent
vim.opt.breakindent = true

-- tabs & indentation
vim.opt.smartindent = true
vim.opt.autoindent = true -- copy indent from current line when starting new one
vim.opt.shiftwidth = 4 -- 4 spaces for indent width
vim.opt.expandtab = true -- expand tab to spaces
vim.opt.tabstop = 4
vim.opt.softtabstop = 4 -- 4 spaces for tabs (prettier default)

-- line wrapping
vim.opt.wrap = true -- disable line wrapping

-- turn off swapfile
-- vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv 'HOME' .. '/.vim/undodir'
-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term

-- [[ search settings ]]
vim.opt.ignorecase = true -- ignore case when searching
vim.opt.incsearch = true
-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'
vim.opt.smartcase = true -- if you include mixed case in your search, assumes you want case-sensitive
-- TIP :%s/\Capple/orange/g
-- The \C forces the search to be case-sensitive.
-- This is useful if you have set case-insensitive searching as your default but want to override it for a specific search and replace.

-- [[ appearance ]]
-- turn on termguicolors for colorschemes to work
-- (have to use iterm2 or any other true color terminal)
vim.opt.termguicolors = true
vim.opt.background = 'dark' -- colorschemes that can be light or dark will be made dark
vim.opt.signcolumn = 'yes' -- show sign column so that text doesn't shift
-- Show which line your cursor is on
vim.opt.cursorline = true

-- backspace
vim.opt.backspace = 'indent,eol,start' -- allow backspace on indent, end of line or insert mode start position

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.opt.timeoutlen = 200

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 20

vim.opt.colorcolumn = '120'

-- [[ set diagnostic symbols ]]
local symbols = { Error = '󰅙', Info = '󰋼', Hint = '󰌵', Warn = '' }
for name, icon in pairs(symbols) do
  local hl = 'DiagnosticSign' .. name
  vim.fn.sign_define(hl, { text = icon, numhl = hl, texthl = hl })
end

-- [[ Global Statusline ]]
vim.opt.laststatus = 3
vim.cmd.hi 'WinSeparator guibg=None'
