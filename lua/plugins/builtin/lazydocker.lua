return {
	"crnvl96/lazydocker.nvim",
	lazy = true,
	cmd = { "LazyDocker" },
	opts = {}, -- automatically calls `require("lazydocker").setup()`
	dependencies = {
		"MunifTanjim/nui.nvim",
	},
	keys = {
		{ "<leader>ld", "<cmd>LazyDocker<cr>", desc = "[L]azy[D]ocker"}
	}
}
