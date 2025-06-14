return {
  disabled = true,
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons',
    'MunifTanjim/nui.nvim',
  },
  cmd = 'Neotree',
  keys = {
    { '<leader>n', ':Neotree toggle<CR>', desc = '[N]eoTree toggle', silent = true },
  },
  opts = {
    filesystem = {
      window = {
        mappings = {
          ['<leader>n'] = 'close_window',
        },
      },
    },
  },
}
