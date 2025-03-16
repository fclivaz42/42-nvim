---@diagnostic disable: missing-fields
local function pushConfig()
	vim.fn.system("git -C ~/.config/nvim add .")
	vim.fn.system("git -C ~/.config/nvim commit -m 'Dashboard config push'")
	local ret = vim.fn.system("git -C ~/.config/nvim push")
	if (vim.v.shell_error ~= 0) then
		vim.notify("Error pushing your config.\nPlease manually review it.", "warn", { title = "42-Nvim", timeout = 3000})
		vim.notify("Trace: " .. ret, "warn", { title = "42-Nvim", timeout = 3000})
	else
		vim.notify("Config pushed!", "info", { title = "42-Nvim"})
	end
end

local function pullConfig()
	local ret = vim.fn.system("git -C ~/.config/nvim pull")
	if (vim.v.shell_error ~= 0) then
		vim.notify("Error pulling your config.\nPlease manually review it.", "warn", { title = "42-Nvim", timeout = 3000})
		vim.notify("Trace: " .. ret, "warn", { title = "42-Nvim", timeout = 3000})
	else
		vim.notify("Config pulled!", "info", { title = "42-Nvim"})
	end
end

local function fetchUpstream()
	if not string.find(vim.fn.system("git -C ~/.config/nvim remote -v"), "upstream") then
		vim.fn.system("git -C ~/.config/nvim remote add upstream https://github.com/fclivaz42/42-nvim.git")
	end
	vim.fn.system("git -C ~/.config/nvim fetch upstream")
	local ret = vim.fn.system("git -C ~/.config/nvim rebase --onto=upstream/main -m 'Dashboard Release Update'")
	if (vim.v.shell_error ~= 0) then
		vim.notify("Error merging from upstsream.\nPlease manually review it.", "warn", { title = "42-Nvim", timeout = 3000})
		vim.notify("Trace: " .. ret, "warn", { title = "42-Nvim", timeout = 3000})
	else
		vim.notify("Config updated!\n Don't forget to push and restart :)", "info", { title = "42-Nvim"})
	end
end

return {
	'nvimdev/dashboard-nvim',
	event = 'VimEnter',
	config = function()
	require('dashboard').setup {
		theme = 'hyper',
		shortcut_type = 'number',
		config = {
			disable_move = true,
			header = {
				'',
				' █🮠██╮██████🮢      ███   ██╮██╮   ██╮██┐███  ███╮',
				'█🮠 ██│    ██│      ████  ██│██│   ██│██│████████│',
				'██████│█████🮠█████╮████ ██│█🮢 █🮠██│████████│',
				'     ██│██🮣──🮠 ╰────╯██│████│ ██🮠 ██│██│██🮠██│',
				'     ██│███████╮      ██│ ████│  ██🮠  ██│██│ 🮡─🮠 ██│',
				'     ╰─╯╰──────╯      ╰─╯  🮡───╯   🮡─🮠   ╰─╯╰─╯     ╰─╯',
				'',
			},
			hide = {
				statusline = true,
				tabline = true,
				winbar = true
			},
			shortcut = {
				{
					icon = '󰊳 ',
					desc = 'Update Plugins',
					group = '@property',
					action = 'Lazy update',
					key = 'u'
				},
				{
					icon = '󰑓 ',
					desc = 'Update 42-Nvim',
					group = 'Label',
					action = fetchUpstream,
					key = 'U',
				},
				{
					icon = ' ',
					desc = 'Push Config',
					group = 'Number',
					action = pushConfig,
					key = 'p',
				},
				{
					icon = ' ',
					desc = 'Pull Config',
					group = 'Number',
					action = pullConfig,
					key = 'P',
				},
			},
			footer = {
				'',
				'42-Nvim V1.6',
				'[ ] https://github.com/fclivaz42/42-nvim',
				'Have a nice day :)'
			},
			project = {
				action = 'Neotree focus filesystem left reveal_force_cwd=true dir=',
			}
		},
	}
	end
}
