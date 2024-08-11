-- Highlight todo, notes, etc in comments
-- BG: Heck yeah banana yello time!
return {
    "folke/todo-comments.nvim",
    event = "VimEnter",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
        signs = false,
        keywords = {
            BG = { icon = " ", color = "banana" },
        },
        colors = {
            banana = { "#ffe135" },
        },
    },
}
