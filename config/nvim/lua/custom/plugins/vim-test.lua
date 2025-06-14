return {
  'vim-test/vim-test',
  keys = {
    { '<Leader>tn', ':silent TestNearest<CR>', desc = '[T]est [N]earest' },
    { '<Leader>tf', ':silent TestFile<CR>', desc = '[T]est [F]ile' },
    { '<Leader>ts', ':silent TestSuite<CR>', desc = '[T]est [S]uite' },
    { '<Leader>tl', ':silent TestLast<CR>', desc = '[T]est [L]ast' },
    { '<Leader>tv', ':silent TestVisit<CR>', desc = '[T]est [V]isit' },
  },
  dependencies = { 'voldikss/vim-floaterm' },
  config = function()
    vim.cmd [[
      function! PhpUnitTransform(cmd) abort
        return join(map(split(a:cmd), 'v:val == "--colors" ? "--colors=always" : v:val'))
      endfunction

      let g:test#custom_transformations = {'phpunit': function('PhpUnitTransform')}
      let g:test#transformation = 'phpunit'

      " let test#php#phpunit#options = '--colors=always'
      let test#php#pest#options = '-v'
      let test#javascript#jest#options = '--color'

      function! FloatermStrategy(cmd)
        execute 'silent FloatermSend q'
        execute 'silent FloatermKill'
        execute 'FloatermNew! '.a:cmd.' | less -R'
      endfunction

      let g:test#custom_strategies = {'floaterm': function('FloatermStrategy')}
      let g:test#strategy = 'floaterm'
    ]]
  end,
}
