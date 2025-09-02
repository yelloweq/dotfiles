return {
  'adibhanna/nvim-notes',
  dependencies = {
    'MunifTanjim/nui.nvim', 
  },
  config = function()
    require('nvim-notes').setup({
      vault_path = '~/notes', 
    })
  end,
}
