-- Autoformat
return {
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },
  keys = {
    {
      '<leader>f',
      function()
        require('conform').format { async = true, lsp_format = 'fallback' }
      end,
      mode = '',
      desc = '[F]ormat buffer',
    },
  },
  opts = {
    notify_on_error = false,
    format_on_save = function(bufnr)
      -- Disable "format_on_save lsp_fallback" for languages that don't
      -- have a well standardized coding style. You can add additional
      -- languages here or re-enable it for the disabled ones.
      local disable_filetypes = { c = true, cpp = true }
      if disable_filetypes[vim.bo[bufnr].filetype] then
        return nil
      else
        return {
          timeout_ms = 1000,
          lsp_format = 'fallback',
        }
      end
    end,
    formatters = {
      ['blade-formatter'] = {
        exe = 'blade-formatter',
        -- we use stdin so we can point it at our buffer name (for .bladeformatterrc
        -- or file‑based config resolution)
        args = function(ctx)
          return {
            '--stdin',
            '--stdin-filepath',
            ctx.bufname,
            '--embedded-language-formatting',
            'off',
          }
        end,
        stdin = true,
      },
    },
    formatters_by_ft = {
      lua = { 'stylua' },
      php = { 'pint' },
      javascript = { 'prettierd', stop_after_first = true },
      typescript = { 'eslint_d', stop_after_first = true },
      typescriptreact = { 'eslint_d', stop_after_first = true },
      blade = { 'blade-formatter' },
      -- Conform can also run multiple formatters sequentially
      -- python = { "isort", "black" },
      --
      -- You can use 'stop_after_first' to run the first available formatter from the list
      -- javascript = { "prettierd", "prettier", stop_after_first = true },
    },
  },
}
