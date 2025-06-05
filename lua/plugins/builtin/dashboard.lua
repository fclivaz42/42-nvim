---@diagnostic disable: missing-fields

local stdpath = vim.fn.stdpath('config')

local function pushConfig()
	vim.fn.system("git -C " .. stdpath .. " add .")
	vim.fn.system("git -C " .. stdpath .. " commit -m 'Dashboard config push'")
	local ret = vim.fn.system("git -C " .. stdpath .. " push")
	if (vim.v.shell_error ~= 0) then
		vim.notify("Error pushing your config.\nPlease manually review it.", vim.log.levels.WARN,
			{ title = "42-Nvim", timeout = 3000 })
		vim.notify("Trace: " .. ret, vim.log.levels.WARN, { title = "42-Nvim", timeout = 3000 })
	else
		vim.notify("Config pushed!", vim.log.levels.INFO, { title = "42-Nvim" })
	end
end

local function pullConfig()
	local ret = vim.fn.system("git -C " .. stdpath .. " pull")
	if (vim.v.shell_error ~= 0) then
		vim.notify("Error pulling your config.\nPlease manually review it.", vim.log.levels.WARN,
			{ title = "42-Nvim", timeout = 3000 })
		vim.notify("Trace: " .. ret, vim.log.levels.WARN, { title = "42-Nvim", timeout = 3000 })
	else
		vim.notify("Config pulled!", vim.log.levels.INFO, { title = "42-Nvim" })
	end
end

local function fetchUpstream()
	if not string.find(vim.fn.system("git -C " .. stdpath .. " remote -v"), "upstream") then
		vim.fn.system("git -C " .. stdpath .. " remote add upstream https://github.com/fclivaz42/42-nvim.git")
	end
	vim.fn.system("git -C " .. stdpath .. " fetch upstream")
	local ret = vim.fn.system("git -C " .. stdpath .. " merge upstream/main -m 'Dashboard Release Update'")
	if (vim.v.shell_error ~= 0) then
		vim.notify("Error merging from upstsream.\nPlease manually review it.", vim.log.levels.WARN,
			{ title = "42-Nvim", timeout = 3000 })
		vim.notify("Trace: " .. ret, vim.log.levels.WARN, { title = "42-Nvim", timeout = 3000 })
	else
		vim.notify("Config updated!\n Don't forget to push and restart :)", vim.log.levels.INFO, { title = "42-Nvim" })
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
					'42-Nvim V1.6-B',
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
