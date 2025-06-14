return {
  {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local harpoon = require 'harpoon'
      harpoon:setup()

      vim.keymap.set('n', '<leader>a', function()
        harpoon:list():add()
      end, { desc = 'Harpoon Add' })
      vim.keymap.set('n', '<C-e>', function()
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end, { desc = 'Harpoon Toggle List' })

      vim.keymap.set('n', '<leader>1', function()
        harpoon:list():select(1)
      end, { silent = true, desc = 'Harpoon Select 1' })
      vim.keymap.set('n', '<leader>2', function()
        harpoon:list():select(2)
      end, { silent = true, desc = 'Harpoon Select 2' })
      vim.keymap.set('n', '<leader>3', function()
        harpoon:list():select(3)
      end, { silent = true, desc = 'Harpoon Select 3' })
      vim.keymap.set('n', '<leader>4', function()
        harpoon:list():select(4)
      end, { silent = true, desc = 'Harpoon Select 4' })

      vim.keymap.set('n', '<C-S-P>', function()
        harpoon:list():prev()
      end, { desc = 'Harpoon previous' })
      vim.keymap.set('n', '<C-S-N>', function()
        harpoon:list():next()
      end, { desc = 'Harpoon next' })
    end,
  },
}
