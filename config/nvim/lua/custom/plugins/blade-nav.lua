-- Add the blade-nav.nvim plugin which provides Goto File capabilities
-- for Blade files.
return {
  'ricardoramirezr/blade-nav.nvim',
  dependencies = {
    'hrsh7th/nvim-cmp',
  },
  ft = { 'blade', 'php' },
}
