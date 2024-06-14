return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
		{
			"MunifTanjim/nui.nvim",
			lazy = true
		},
		{
			"3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
			lazy = true
		},
		{
			"s1n7ax/nvim-window-picker",
			lazy = true,
			opts = {
				hint = 'statusline-winbar',
				selection_chars= '1234567890QWERTYUIOP'
			}
		}
	}
}
