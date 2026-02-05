-- [[ Enable conform.nvim ]] --
--
-- As I said in extras/conform.lua, I really like conform.
-- It is disabled by default, however. This is its main configuration file.
--

vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	callback = function(args)
		require("conform").format({ bufnr = args.buf })
	end,
})
