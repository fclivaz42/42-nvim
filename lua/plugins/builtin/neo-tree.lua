return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		{
			"nvim-lua/plenary.nvim",
			lazy = true
		},
		"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
		{
			"MunifTanjim/nui.nvim",
			lazy = true
		},
		{
			"s1n7ax/nvim-window-picker",
			name = 'window-picker',
			event = 'VeryLazy',
			opts = {
				hint = 'statusline-winbar',
				selection_chars= 'QWERTYUIOPASDFGHJKL',
				vim.api.nvim_create_autocmd("ColorScheme", {
					pattern = "*",
					callback = function()
						vim.api.nvim_set_hl(0, "WindowPickerStatusLine", { bold = true, bg = "#e35e4f", fg = "#ededed"})
						vim.api.nvim_set_hl(0, "WindowPickerStatusLineNC", { bold = true, bg = "#333355", fg = "#FFFFFF"})
					end
				})
			}
		}
	}
}
