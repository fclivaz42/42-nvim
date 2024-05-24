return {
	-- OneDark, inspired by Atom. Default style is darker but you can...
	'navarasu/onedark.nvim',
	opts = {
		style = 'darker',
		-- ...switch themes using this keybind!
		toggle_style_key = "<leader>st",
		term_colors = false,
		lualine = {
			transparent = true
		}
	},
	priority = 1000,
}
