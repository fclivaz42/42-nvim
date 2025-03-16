local function getMode()
	local var = require('wrapping').get_current_mode()
	if var == nil then
		return [[]]
	elseif var == 'soft' then
		return [[󱞥]]
	else
		return [[󰞔]]
	end
end

vim.keymap.set('n', ";[", require('wrapping').soft_wrap_mode, { desc = 'Soft Wrap mode' })
vim.keymap.set('n', ";]", require('wrapping').hard_wrap_mode, { desc = 'Hard Wrap mode' })
vim.keymap.set('n', ";\\", require('wrapping').toggle_wrap_mode, { desc = 'Toggle Wrap mode' })

require('lualine').setup {
	options = {
		disabled_filetypes = {
			'dashboard',
			'Dashboard'
		}
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
		'lazy'
	}
}
