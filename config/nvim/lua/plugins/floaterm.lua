return {
  'voldikss/vim-floaterm',
  config = function()
    -- Set floaterm options
    vim.g.floaterm_width = 0.8
    vim.g.floaterm_height = 0.8
    vim.g.floaterm_position = 'center'
    vim.g.floaterm_borderchars = '─│─│╭╮╯╰'
    vim.g.floaterm_title = 'Terminal ($1/$2)'

    -- Key mappings
    vim.keymap.set('n', '<F1>', ':FloatermToggle<CR>', { silent = true })
    vim.keymap.set('t', '<F1>', '<C-\\><C-n>:FloatermToggle<CR>', { silent = true })

    -- Optional: Additional useful mappings
    vim.keymap.set('t', 'q', '<C-\\><C-n>:FloatermHide<CR>', { silent = true })
  end
}
