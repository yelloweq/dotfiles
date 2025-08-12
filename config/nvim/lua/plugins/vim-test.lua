return {
  'vim-test/vim-test',
  dependencies = {
    'voldikss/vim-floaterm'
  },
  config = function()
    -- Configure vim-test to use floaterm
    vim.g['test#strategy'] = 'floaterm'
    
    -- PHPUnit specific settings
    vim.g['test#php#phpunit#executable'] = 'vendor/bin/phpunit'
    vim.g['test#php#phpunit#options'] = '--colors=always'
    
    -- Floaterm settings for tests
    vim.g['test#floaterm#term_position'] = 'center'
    vim.g['test#floaterm#term_width'] = 0.8
    vim.g['test#floaterm#term_height'] = 0.8
    
    -- Key mappings
    vim.keymap.set('n', '<leader>tn', ':TestNearest<CR>', { 
      silent = true, 
      desc = 'Test nearest' 
    })
    vim.keymap.set('n', '<leader>tf', ':TestFile<CR>', { 
      silent = true, 
      desc = 'Test file' 
    })
    vim.keymap.set('n', '<leader>ts', ':TestSuite<CR>', { 
      silent = true, 
      desc = 'Test suite' 
    })
    vim.keymap.set('n', '<leader>tl', ':TestLast<CR>', { 
      silent = true, 
      desc = 'Test last' 
    })
  end
}
