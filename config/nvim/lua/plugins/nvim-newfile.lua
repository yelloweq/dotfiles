return {
    "adibhanna/nvim-newfile.nvim",
    config = function()
        require("nvim-newfile").setup({
            notifications = {
                enabled = false, -- Set to false to disable file creation notifications
            },
        })
    end,
}
