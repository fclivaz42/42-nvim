local function getMode()
	local var = require('wrapping').get_current_mode()
	if var == nil then
		return [[󰞔]]
	elseif var == 'soft' then
		return [[󱞥]]
	else
		return [[󰞔]]
	end
end

local dashboard = {
	sections = {},
	filetypes = {
		statusline = {
			'dashboard'
		},
		winbar = {
			'dashboard'
		}
	},
}

require('lualine').setup {
	disabled_filetypes = {
		'dashboard'
	},
	sections = {
		lualine_c = {
			'filename'
		},
		lualine_x = {
			getMode,
			'fileformat',
			'filetype'
		}
	},
	extensions = {
		'nvim-tree',
		'neo-tree',
		'mason',
		'lazy',
		dashboard
	}
}
