return {
   "nvim-lualine/lualine.nvim",
   dependencies = { "nvim-tree/nvim-web-devicons" },
   config = function()
      local lualine = require("lualine")
      lualine.setup({
         options = { section_separators = "", component_separators = "" },
         sections = {
            lualine_a = { "mode" },
            lualine_b = { "branch", "diff", "diagnostics" },
            lualine_c = { "filename" },
            lualine_x = { "filetype" },
            -- lualine_y = {},
            lualine_z = { "location" },
         },
      })
   end,
}
