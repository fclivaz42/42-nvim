local function pushConfig()
	vim.cmd("cd ~/.config/nvim")
	vim.cmd("silent !git add .")
	vim.cmd("silent !git commit -m 'dashboard-update'")
	vim.cmd("silent !git push")
	if (vim.v.shell_error ~= 0) then
		vim.notify("Error pushing your config.\nPlease manually review it.")
	else
		vim.notify("Config pushed!")
	end
end

local function pullConfig()
	vim.cmd("cd ~/.config/nvim")
	vim.cmd("silent !git pull")
	if (vim.v.shell_error ~= 0) then
		vim.notify("Error pulling your config.\nPlease manually review it.")
	else
		vim.notify("Config pulled!")
	end
end

local function fetchUpstream()
	vim.cmd("cd ~/.config/nvim")
	vim.cmd("silent !git fetch upstream")
	vim.cmd("silent !git merge upstream/main -m 'Update 42-Nvim'")
	if (vim.v.shell_error ~= 0) then
		vim.notify("Error merging from upstsream.\nPlease manually review it.")
	else
		vim.notify("42-Nvim updated!")
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
				'██╗  ██╗██████╗       ███╗   ██╗██╗   ██╗██╗███╗   ███╗',
				'██║  ██║╚════██╗      ████╗  ██║██║   ██║██║████╗ ████║',
				'███████║ █████╔╝█████╗██╔██╗ ██║██║   ██║██║██╔████╔██║',
				'╚════██║██╔═══╝ ╚════╝██║╚██╗██║╚██╗ ██╔╝██║██║╚██╔╝██║',
				'     ██║███████╗      ██║ ╚████║ ╚████╔╝ ██║██║ ╚═╝ ██║',
				'     ╚═╝╚══════╝      ╚═╝  ╚═══╝  ╚═══╝  ╚═╝╚═╝     ╚═╝',
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
				'Don\'t forget to check upstream (and star it) for updates!',
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
