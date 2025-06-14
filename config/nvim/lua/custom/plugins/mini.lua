-- Collection of various small independent plugins/modules
return {
  'echasnovski/mini.nvim',
  config = function()
    -- Better Around/Inside textobjects
    --
    -- Examples:
    --  - va)  - [V]isually select [A]round [)]paren
    --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
    --  - ci'  - [C]hange [I]nside [']quote
    require('mini.ai').setup { n_lines = 500 }

    -- Add/delete/replace surroundings (brackets, quotes, etc.)
    --
    -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
    -- - sd'   - [S]urround [D]elete [']quotes
    -- - sr)'  - [S]urround [R]eplace [)] [']
    require('mini.surround').setup()
    -- require('mini.move').setup()
    require('mini.notify').setup()
    require('mini.icons').setup()
    -- require('mini.animate').setup()
    -- require('mini.files').setup {
    --   windows = {
    --     -- Floating window with rounded border
    --     preview = true,
    --     width_focus = 40,
    --     width_nofocus = 30,
    --     height = 100,
    --     border = 'rounded',
    --   },
    --   options = {
    --     -- Show hidden files
    --     show_hidden = true,
    --     -- Use icons if available
    --     use_as_default_explorer = true,
    --   },
    -- }
    require('mini.starter').setup()

    -- Simple and easy statusline.
    --  You could remove this setup call if you don't like it,
    --  and try some other statusline plugin
    local statusline = require 'mini.statusline'
    -- set use_icons to true if you have a Nerd Font
    statusline.setup { use_icons = vim.g.have_nerd_font }

    -- You can configure sections in the statusline by overriding their
    -- default behavior. For example, here we set the section for
    -- cursor location to LINE:COLUMN
    ---@diagnostic disable-next-line: duplicate-set-field
    statusline.section_location = function()
      return '%2l:%-2v'
    end

    -- mini keymaps
    -- vim.keymap.set('n', '<leader>n', function()
    --   local mf = require 'mini.files'
    --   if not mf.close() then
    --     mf.open(vim.loop.cwd())
    --   end
    -- end, { desc = 'Toggle mini.files in current directory' })
    -- ... and there is more!
    --  Check out: https://github.com/echasnovski/mini.nvim
  end,
}
