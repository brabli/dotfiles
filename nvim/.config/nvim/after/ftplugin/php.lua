-- Fix PHP comments

-- vim.api.nvim_set_option("commentstring", "// %s")
-- Why does commentstring work here but not for twig?
vim.bo.commentstring = "// %s"
