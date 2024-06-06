local function getMode()
	local var = require('wrapping').get_current_mode()
	if var == nil then
		return [[No Wrapping]]
	elseif var == 'soft' then
		return [[Soft Wrap]]
	else
		return [[Hard Wrap]]
	end
end

require('lualine').setup {
	sections = {
		lualine_c = {
			getMode,
			'filename'
		}
	}
}
