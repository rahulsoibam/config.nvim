return { -- Fuzzy Finder (files, lsp, etc)
  'nvim-telescope/telescope.nvim',
  event = 'VimEnter',
  branch = '0.1.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    { -- If encountering errors, see telescope-fzf-native README for installation instructions
      'nvim-telescope/telescope-fzf-native.nvim',

      -- `build` is used to run some command when the plugin is installed/updated.
      -- This is only run then, not every time Neovim starts up.
      build = 'make',

      -- `cond` is a condition used to determine whether this plugin should be
      -- installed and loaded.
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },
    { 'nvim-telescope/telescope-ui-select.nvim' },

    -- Useful for getting pretty icons, but requires a Nerd Font.
    { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
  },
  config = function()
    -- Telescope is a fuzzy finder that comes with a lot of different things that
    -- it can fuzzy find! It's more than just a "file finder", it can search
    -- many different aspects of Neovim, your workspace, LSP, and more!
    --
    -- The easiest way to use Telescope, is to start by doing something like:
    --  :Telescope help_tags
    --
    -- After running this command, a window will open up and you're able to
    -- type in the prompt window. You'll see a list of `help_tags` options and
    -- a corresponding preview of the help.
    --
    -- Two important keymaps to use while in Telescope are:
    --  - Insert mode: <c-/>
    --  - Normal mode: ?
    --
    -- This opens a window that shows you all of the keymaps for the current
    -- Telescope picker. This is really useful to discover what Telescope can
    -- do as well as how to actually do it!

    -- [[ Configure Telescope ]]
    -- See `:help telescope` and `:help telescope.setup()`
    require('telescope').setup {
      -- You can put your default mappings / updates / etc. in here
      --  All the info you're looking for is in `:help telescope.setup()`
      defaults = { -- configure to use ripgrep
        vimgrep_arguments = {
          'rg',
          '--follow', -- Follow symbolic links
          '--hidden', -- Search for hidden files
          '--no-heading', -- Don't group matches by each file
          '--with-filename', -- Print the file path with the matched lines
          '--line-number', -- Show line numbers
          '--column', -- Show column numbers
          '--smart-case', -- Smart case search

          -- Exclude some patterns from search
          '--glob=!**/.git/*',
          '--glob=!**/.idea/*',
          '--glob=!**/.vscode/*',
          '--glob=!**/build/*',
          '--glob=!**/dist/*',
          '--glob=!**/yarn.lock',
          '--glob=!**/package-lock.json',
        },
        path_display = { 'truncate ' },
        mappings = {
          i = {
            ['<C-k>'] = require('telescope.actions').move_selection_previous, -- move to prev result
            ['<C-j>'] = require('telescope.actions').move_selection_next, -- move to next result
            ['<C-q>'] = require('telescope.actions').send_selected_to_qflist + require('telescope.actions').open_qflist,
            ['<c-enter>'] = 'to_fuzzy_refine',
          },
        },
      },
      pickers = {
        find_files = {
          hidden = true,
          -- needed to exclude some files & dirs from general search
          -- when not included or specified in .gitignore
          find_command = {
            'rg',
            '--files',
            '--hidden',
            '--glob=!**/.git/*',
            '--glob=!**/.idea/*',
            '--glob=!**/.vscode/*',
            '--glob=!**/build/*',
            '--glob=!**/dist/*',
            '--glob=!**/yarn.lock',
            '--glob=!**/package-lock.json',
          },
        },
      },
      extensions = {
        ['ui-select'] = {
          require('telescope.themes').get_dropdown(),
        },
      },
    }

    -- Enable Telescope extensions if they are installed
    pcall(require('telescope').load_extension, 'fzf')
    pcall(require('telescope').load_extension, 'ui-select')
    -- See `:help telescope.builtin`
    local builtin = require 'telescope.builtin'
    vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
    vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
    -- Lists files in your current working directory, respects .gitignore
    -- keymap is ss because I suspect I will be using this the most
    vim.keymap.set('n', '<leader>ss', builtin.find_files, { desc = '[S]earch files' })
    -- Fuzzy search through the output of git ls-files command, respects .gitignore
    vim.keymap.set('n', '<leader>sf', builtin.git_files, { desc = '[S]earch git [F]iles' })
    -- Lists Built-in pickers and run them on <cr>.
    vim.keymap.set('n', '<leader>sp', builtin.builtin, { desc = '[S]earch builtin telescope [P]ickers' })
    -- Searches for the string under your cursor or selection in your current working directory
    vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
    -- Search for a string in your current working directory and get results live as you type, respects .gitignore. (Requires ripgrep)
    vim.keymap.set('n', '<leader>sl', builtin.live_grep, { desc = '[S]earch by [L]ive grep' })
    -- Lists Diagnostics for all open buffers or a specific buffer. Use option bufnr=0 for current buffer.
    vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
    -- Lists the results incl. multi-selections of the previous picker
    vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
    -- Lists previously open files
    vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
    -- Lists open buffers in current neovim instance
    vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })

    -- Slightly advanced example of overriding default behavior and theme
    vim.keymap.set('n', '<leader>/', function()
      -- You can pass additional configuration to Telescope to change the theme, layout, etc.
      builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        winblend = 10,
        previewer = false,
      })
    end, { desc = '[/] Fuzzily search in current buffer' })

    -- It's also possible to pass additional configuration options.
    --  See `:help telescope.builtin.live_grep()` for information about particular keys
    vim.keymap.set('n', '<leader>s/', function()
      builtin.live_grep {
        grep_open_files = true,
        prompt_title = 'Live Grep in Open Files',
      }
    end, { desc = '[S]earch [/] in Open Files' })

    -- Shortcut for searching your Neovim configuration files
    vim.keymap.set('n', '<leader>sn', function()
      builtin.find_files { cwd = vim.fn.stdpath 'config' }
    end, { desc = '[S]earch [N]eovim files' })

    -- Telescope live_grep in git root
    -- Function to find the git root directory based on the current buffer's path
    local function find_git_root()
      -- Use the current buffer's path as the starting point for the git search
      local current_file = vim.api.nvim_buf_get_name(0)
      local current_dir
      local cwd = vim.fn.getcwd()

      -- fix for when oil.nvim is used instead of netrw
      -- check if the path starts with the 'oil://' scheme and remove it
      if string.sub(current_file, 1, 6) == 'oil://' then
        current_file = string.sub(current_file, 7)
      end
      -- If the buffer is not associated with a file, return nil
      if current_file == '' then
        current_dir = cwd
      else
        -- Extract the directory from the current file's path
        current_dir = vim.fn.fnamemodify(current_file, ':h')
      end

      -- Find the Git root directory from the current file's path
      local git_root =
        vim.fn.systemlist('git -C ' .. vim.fn.escape(current_dir, ' ') .. ' rev-parse --show-toplevel')[1]

      if vim.v.shell_error ~= 0 then
        print 'Not a git repository. Searching on current working directory'
        return cwd
      end
      return git_root
    end

    -- Custom live_grep function to search in git root
    local function live_grep_git_root()
      local git_root = find_git_root()
      if git_root then
        builtin.live_grep {
          search_dirs = { git_root },
        }
      end
    end

    vim.api.nvim_create_user_command('LiveGrepGitRoot', live_grep_git_root, {})

    vim.keymap.set('n', '<leader>sg', ':LiveGrepGitRoot<cr>', { desc = '[S]earch by [G]rep on Git Root' })
  end,
}
