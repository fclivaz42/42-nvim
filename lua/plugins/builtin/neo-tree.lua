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
			"3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
			lazy = true
		},
		{
			"s1n7ax/nvim-window-picker",
			event = 'VeryLazy',
			opts = {
				hint = 'statusline-winbar',
				selection_chars= 'QWERTYUIOPASDFGHJKL',
			    highlights = {
					statusline = {
            			focused = {
							fg = '#ededed',
							bg = '#e35e4f',
							bold = true,
						},
						unfocused = {
							fg = '#ededed',
							bg = '#44cc41',
							bold = true,
						},
					},
				}
			}
		}
	}
}
