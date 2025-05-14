local function getPhpCsConfigFile()
   local path1 = "app/.php-cs-fixer.dist.php"
   local path2 = ".php-cs-fixer.dist.php"

   local file = io.open(path1, "r")
   if file then
      file:close()
      return path1
   else
      file = io.open(path2, "r")
      if file then
         file:close()
         return path2
      else
         return ""
      end
   end
end

return {
   "stevearc/conform.nvim",
   lazy = false,
   keys = {
      {
         "<leader>f",
         function()
            require("conform").format({ async = true, lsp_fallback = true })
         end,
         mode = "",
         desc = "[F]ormat buffer",
      },
   },
   opts = {
      notify_on_error = true,
      format_on_save = function(bufnr)
         -- Disable "format_on_save lsp_fallback" for languages that don't
         -- have a well standardized coding style. You can add additional
         -- languages here or re-enable it for the disabled ones.
         local disable_filetypes = { c = true, cpp = true, php = true }
         return {
            timeout_ms = 1000,
            lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
         }
      end,
      formatters_by_ft = {
         lua = { "stylua" },
         php = { "php-cs-fixer" },
         typescript = { "biome" },
         javascript = { "biome" },
         json = { "biome" },
         jsonc = { "biome" },
      },
      formatters = {
         formatters = {
            ["php-cs-fixer"] = {
               command = "php-cs-fixer",
               args = {
                  "fix",
                  "$FILENAME",
                  "--config=" .. getPhpCsConfigFile(),
                  "--allow-risky=yes",
               },
               stdin = false,
            },
         },
      },
   },
}
