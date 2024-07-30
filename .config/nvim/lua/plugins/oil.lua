function CloseOil()
    local bufnr = vim.api.nvim_get_current_buf()
    if vim.bo[bufnr].filetype == "oil" then
        vim.cmd("bd") -- or :q if you prefer
    end
end

return {
    "stevearc/oil.nvim",

    -- Optional dependencies
    dependencies = { "nvim-tree/nvim-web-devicons" },

    config = function()
        require("oil").setup({
            columns = {
                "icon",
                "permissions",
                -- "size",
                -- "mtime",
            },
            keymaps = {
                ["<C-h>"] = false,
                ["<C-l>"] = false,
                ["<C-k>"] = false,
                ["<C-j>"] = false,

                ["<C-c"] = false,
                -- ["<M-h>"] = "actions.select_split",
            },
            view_options = {
                show_hidden = true,
            },
            extensions = {
                -- Add your custom icon associations here
                ["env.dist"] = {
                    icon = require("nvim-web-devicons").get_icon("env", "env"), -- get the .env icon
                    color = require("nvim-web-devicons").get_icon_color("env", "env"), -- get the .env icon color
                    name = "EnvDist",
                },
            },
        })

        vim.api.nvim_create_autocmd("FileType", {
            pattern = "oil",
            callback = function()
                vim.api.nvim_buf_set_keymap(0, "n", "<Esc>", ":lua CloseOil()<CR>", { noremap = true, silent = true })
            end,
        })

        -- Open parent directory in current window
        vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

        -- vim.keymap.set("n", "<esc>", require("oil").close)

        -- Open parent directory in floating window
        vim.keymap.set("n", "<space>-", require("oil").toggle_float)
    end,
}
