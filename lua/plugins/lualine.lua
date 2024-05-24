local colors = {
	black	= '#161821',
	purple	= '#c792ea',
	lgray	= '#c6c8d1',
	dgray	= '#2e313f',
	orang	= '#e2a478',
	inblue	= '#3e445e',
	black2	= '#0f1117',
	green	= '#6f9e50',
	lblue	= '#80a0ff',
	yellow	= '#e5c07b',
	cyan	= '#56b6c2',
}

local personalberg = {
	visual = {
		a = { fg = colors.black, bg = colors.purple, gui = 'bold' },
		b = { fg = colors.lgray, bg = colors.dgray },
	},
	replace = {
		a = { fg = colors.black, bg = colors.orang, gui = 'bold' },
		b = { fg = colors.lgray, bg = colors.dgray },
	},
	inactive = {
		a = { fg = colors.inblue, bg = colors.black2, gui = 'bold' },
		b = { fg = colors.inblue, bg = colors.black2 },
		c = { fg = colors.inblue, bg = colors.black2 },
	},
	normal = {
		a = { fg = colors.black2, bg = colors.green, gui = 'bold' },
		b = { fg = colors.lgray, bg = colors.dgray },
		c = { fg = colors.lgray, bg = colors.black2 },
	},
	insert = {
		a = { fg = colors.black, bg = colors.lblue, gui = 'bold' },
		b = { fg = colors.lgray, bg = colors.dgray },
	},
	command = {
		a = { fg = colors.black, bg = colors.yellow, gui = 'bold' }
	},
	terminal = {
		a = { fg = colors.black2, bg = colors.cyan, gui = 'bold' }
	},
}

local function get_short_cwd()
  return vim.fn.fnamemodify(vim.fn.getcwd(), ':~')
end

local treextension = {
	sections = {
		lualine_a = { get_short_cwd },
	},
	filetypes = { 'NvimTree' }
}
return {
	-- Set lualine as statusline
	'nvim-lualine/lualine.nvim',
	-- See `:help lualine.txt`
	opts = {
		options = {
			icons_enabled = true,
			theme = personalberg,
			component_separators = '|',
			section_separators = '',
			},
		extensions = { 'nvim-tree', 'mason', 'lazy' },
	},
}
