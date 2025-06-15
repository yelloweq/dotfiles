-- Collection of various small independent plugins/modules
return {
  'echasnovski/mini.nvim',
  config = function()
    require('mini.ai').setup { n_lines = 500 }
    require('mini.surround').setup()
    -- require('mini.move').setup()
    require('mini.notify').setup()
    require('mini.icons').setup()
    require('mini.files').setup {
      windows = {
        preview = true,
        width_focus = 40,
        width_preview = 50,
        width_nofocus = 30,
        height = 100,
        border = 'rounded',
      },
      options = {
        show_hidden = true,
        use_as_default_explorer = true,
      },
    }
    require('mini.starter').setup()
    local statusline = require 'mini.statusline'
    statusline.setup { use_icons = vim.g.have_nerd_font }

    -- You can configure sections in the statusline by overriding their
    -- default behavior. For example, here we set the section for
    -- cursor location to LINE:COLUMN
    ---@diagnostic disable-next-line: duplicate-set-field
    statusline.section_location = function()
      return '%2l:%-2v'
    end

    local mf = require 'mini.files'

    -- mini keymaps
    vim.keymap.set('n', '<leader>fm', function()
      local current_file = vim.api.nvim_buf_get_name(0)

      local path_to_open
      if current_file ~= '' and vim.fn.filereadable(current_file) == 1 then
        path_to_open = current_file
      else
        path_to_open = vim.fn.getcwd()
      end
      local _ = mf.close() or mf.open(path_to_open)
      vim.defer_fn(function()
        mf.reveal_cwd()
      end, 30)
    end, { desc = 'Toggle mini.files at current file/CWD' })

    vim.keymap.set('n', '<leader>fM', function()
      if not mf.close() then
        mf.open(vim.fn.getcwd())
      end
    end, { desc = 'Toggle mini.files at project root' })
  end,
}
