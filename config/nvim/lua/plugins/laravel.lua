return {
  {
    'adibhanna/laravel.nvim',
    ft = { 'php', 'blade' },
    dependencies = {
      'folke/snacks.nvim', 
    },
    config = function()
      require('laravel').setup({
        notifications = false,
        debug = false,
        keymaps = true
      })
    end,
  },

  {
    'adibhanna/phprefactoring.nvim',
    enabled = false,
    dependencies = {
      'MunifTanjim/nui.nvim',
    },
    ft = 'php',
    config = function()
      require('phprefactoring').setup()
    end,
  },
}
