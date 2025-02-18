return {
	-- Add indentation guides even on blank lines
	'lukas-reineke/indent-blankline.nvim',
	-- Enable `lukas-reineke/indent-blankline.nvim`
	-- See `:help indent_blankline.txt`
	main = "ibl",
	opts = {
		indent = {
			char = '│',
			tab_char = '│',
		},
		whitespace = {
			highlight = { "Whitespace", "Nontext" }
		},
		scope = {
			highlight = {"Function", "Label"},
			show_start = false,
			show_end = false,
		},
		exclude = {
			filetypes = {
				"dashboard",
				"lspinfo",
				"packer",
				"checkhealth",
				"help",
				"man",
				"gitcommit",
				"TelescopePrompt",
				"TelescopeResults",
				""
			},
		}
	}
}
