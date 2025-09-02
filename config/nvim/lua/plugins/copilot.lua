return {
  {
    'github/copilot.vim',
    enabled = true,
    cmd = 'Copilot',
    build = ':Copilot auth',
    event = 'InsertEnter',
    config = function()
      vim.g.copilot_no_tab_map = true
      vim.api.nvim_set_keymap('i', '<C-e>', 'copilot#Accept()', { silent = true, expr = true, noremap = true })
    end,
  },
}
