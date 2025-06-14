-- Auto rename and close HTML tags

return {
  'windwp/nvim-ts-autotag',
  config = function()
    local autotag = require 'nvim-ts-autotag' -- Corrected the require path
    autotag.setup {
      -- Set up aliases for file types
      filetypes = {
        html = true,
        blade = true, -- Enable for Blade files
      },
      -- You can add more configuration options here if needed
    }
  end,
}
