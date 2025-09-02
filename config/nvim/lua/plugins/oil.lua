return {
  'stevearc/oil.nvim',
  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {
    default_file_explorer = true,
    columns = {
      "icon",
      "size"
    },
    delete_to_trash = true,
    skip_confirm_for_simple_edits = true,
    float = {
      padding = 2,
      max_width = 180,
      max_height = 30,
    },
    keymaps = {
      ["<CR>"] = "actions.select",
      ["q"] = "actions.close",
    },
  },
  keys = {
    {
      "<leader>fm",
      function()
        require("oil").open_float()
      end,
      desc = "Open oil in floating window",
    },
  },
  dependencies = { { "echasnovski/mini.icons", opts = {} } },
  lazy = false,
}
