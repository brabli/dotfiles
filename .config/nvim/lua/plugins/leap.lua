return {
    "ggandor/leap.nvim",
    opts = {
        setup = function()
            require("leap").create_default_mappings()
        end,
    },
}
