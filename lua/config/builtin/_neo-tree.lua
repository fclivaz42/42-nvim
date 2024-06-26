--[[ NeoTree configuration ]]--

-- Function to read the dashboard cache
local function readDache()
    local cachedir = vim.fn.stdpath('cache') .. "/" .. 'dashboard'
	if vim.fn.isdirectory(cachedir) then
		vim.fn.mkdir(cachedir, 'p')
	end
    local cache = cachedir .. '/' .. 'cache'
	local fd = vim.loop.fs_open(cache, "r", tonumber('644', 8))
	if fd == nil then
		local fd2 = assert(vim.loop.fs_open(cache, "w", tonumber('644', 8)))
		vim.loop.fs_close(fd2)
		return {}
	end
	local stat = assert(vim.loop.fs_fstat(fd))
	local contents = vim.loop.fs_read(fd, stat.size, 0)
        ---@diagnostic disable-next-line: param-type-mismatch
	local dump = assert(loadstring(contents))
	vim.loop.fs_close(fd)
	return dump()
end

-- Function to write to the dashboard cache
local function writeToDache(content)
    local cachedir = vim.fn.stdpath('cache') .. "/" .. 'dashboard'
	if vim.fn.isdirectory(cachedir) then
		vim.fn.mkdir(cachedir, 'p')
	end
    local cache = cachedir .. '/' .. 'cache'
	local fd = assert(vim.loop.fs_open(cache, "w", tonumber('644', 8)))
	local dump = 'return ' .. vim.inspect(content)
	vim.loop.fs_write(fd, dump, 0)
	vim.loop.fs_close(fd)
end

require("neo-tree").setup({
	source_selector = {
		winbar = true,
		content_layout = 'center',
		sources = {
			{
				source = 'filesystem',
				display_name = '󰉓 Files'
			},
			{
				source = 'buffers',
				display_name = '󰈚 Bufs'
			},
			{
				source = 'git_status',
				display_name = '󰊢 Git'
			},
			-- {
			-- 	source = 'document_symbols',
			-- 	display_name = '󰊕'
			-- }
		},
	},
	close_if_last_window = false,
	sources = {
		'filesystem',
		'buffers',
		'git_status',
		'document_symbols'
	},
	window = {
		position = "left",
		width = 32,
		mapping_options = {
			noremap = true,
			nowait = true,
		},
		mappings = {
			['e'] = function() vim.cmd('Neotree focus filesystem left') end,
			['b'] = function() vim.cmd('Neotree focus buffers left') end,
			['g'] = function() vim.cmd('Neotree focus git_status left') end,
			["<space>"] = {
				"toggle_node",
				nowait = false
			},
			["<2-LeftMouse>"] = "open_with_window_picker",
			["<cr>"] = "open_with_window_picker",
			["<esc>"] = "cancel", -- close preview or floating neo-tree window
			["P"] = {
				"toggle_preview",
				config = {
					use_float = true,
					use_image_nvim = true
				}
			},
			-- Read `# Preview Mode` for more information
			["l"] = "focus_preview",
			["<C-v>"] = "vsplit_with_window_picker",
			["<C-x>"] = "split_with_window_picker",
			-- ["S"] = "split_with_window_picker",
			-- ["s"] = "vsplit_with_window_picker",
			["t"] = "open_tabnew",
			-- ["<cr>"] = "open_drop",
			-- ["t"] = "open_tab_drop",
			["w"] = "open",
			--["P"] = "toggle_preview", -- enter preview mode, which shows the current node without focusing
		--	["C"] = "close_node",
			-- ['C'] = 'close_all_subnodes',
			["z"] = "close_all_nodes",
			--["Z"] = "expand_all_nodes",
			["a"] = {
			  "add",
			  -- this command supports BASH style brace expansion ("x{a,b,c}" -> xa,xb,xc). see `:h neo-tree-file-actions` for details
			  -- some commands may take optional config options, see `:h neo-tree-mappings` for details
			  config = {
			    show_path = "none" -- "none", "relative", "absolute"
			  }
			},
			["A"] = "add_directory", -- also accepts the optional config.show_path option like "add". this also supports BASH style brace expansion.
			["d"] = "delete",
			["r"] = "rename",
		--	["y"] = "copy_to_clipboard",
			["C"] = "copy", -- takes text input for destination, also accepts the optional config.show_path option like "add":
			["x"] = "cut_to_clipboard",
			["p"] = "paste_from_clipboard",
			["c"] = "copy_to_clipboard",
			-- ["c"] = {
			--  "copy",
			--  config = {
			--    show_path = "none" -- "none", "relative", "absolute"
			--  }
			--}
			["m"] = "move", -- takes text input for destination, also accepts the optional config.show_path option like "add".
			["q"] = "close_window",
			["R"] = "refresh",
			["?"] = "show_help",
			["<"] = "prev_source",
			[">"] = "next_source",
			["i"] = "show_file_details",
		}
	},
	nesting_rules = {},
	filesystem = {
		commands = {
			addToDash = function(state)
				local node = state.tree:get_node()
				local path = node:get_id()
				local content = readDache()
				local x = 1
				if content == nil then
					content = {}
				end
				for _,i in pairs(content) do
					if i == path then
						table.remove(content, x)
						writeToDache(content)
						vim.notify("Removed " .. path .. " from Dashboard shortcuts.")
						return
					end
					x = x + 1
				end
				table.insert(content, path)
				writeToDache(content)
				vim.notify("Added " .. path .. " to Dashboard shortcuts.")
			end
		},
		filtered_items = {
			visible = false, -- when true, they will just be displayed differently than normal items
			hide_dotfiles = true,
			hide_gitignored = true,
			hide_hidden = true, -- only works on Windows for hidden files/directories
			hide_by_name = {
				--"node_modules"
			},
			hide_by_pattern = { -- uses glob style patterns
				--"*.meta",
				--"*/src/*/tsconfig.json",
			},
			always_show = { -- remains visible even if other settings would normally hide it
				".gitignore",
			},
			always_show_by_pattern = { -- uses glob style patterns
				--".env*",
			},
			never_show = { -- remains hidden even if visible is toggled to true, this overrides always_show
				".DS_Store",
				"thumbs.db"
			},
			never_show_by_pattern = { -- uses glob style patterns
				--".null-ls_*",
			},
		},
		follow_current_file = {
			enabled = false, -- This will find and focus the file in the active buffer every time
							-- the current file is changed while the tree is open.
			leave_dirs_open = true, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
		},
		group_empty_dirs = false, -- when true, empty folders will be grouped together
		hijack_netrw_behavior = "open_default", -- netrw disabled, opening a directory opens neo-tree
													-- in whatever position is specified in window.position
								  -- "open_current",  -- netrw disabled, opening a directory opens within the
													-- window like netrw would, regardless of window.position
								  -- "disabled",    -- netrw left alone, neo-tree does not handle opening dirs
		use_libuv_file_watcher = true, -- This will use the OS level file watchers to detect changes
											-- instead of relying on nvim autocmd events.
		window = {
			mappings = {
				["<C-K>"] = "addToDash",
				["<bs>"] = "navigate_up",
				["."] = "set_root",
				["H"] = "toggle_hidden",
				["/"] = "fuzzy_finder",
				["D"] = "fuzzy_finder_directory",
				["#"] = "fuzzy_sorter", -- fuzzy sorting using the fzy algorithm
				-- ["D"] = "fuzzy_sorter_directory",
				["f"] = "filter_on_submit",
				["<c-J>"] = "clear_filter",
				["[g"] = "prev_git_modified",
				["]g"] = "next_git_modified",
				["o"] = { "show_help", nowait=false, config = { title = "Order by", prefix_key = "o" }},
				["oc"] = { "order_by_created", nowait = false },
				["od"] = { "order_by_diagnostics", nowait = false },
				["og"] = { "order_by_git_status", nowait = false },
				["om"] = { "order_by_modified", nowait = false },
				["on"] = { "order_by_name", nowait = false },
				["os"] = { "order_by_size", nowait = false },
				["ot"] = { "order_by_type", nowait = false },
				-- ['<key>'] = function(state) ... end,
			},
			fuzzy_finder_mappings = { -- define keymaps for filter popup window in fuzzy_finder_mode
				["<down>"] = "move_cursor_down",
				["<C-n>"] = "move_cursor_down",
				["<up>"] = "move_cursor_up",
				["<C-p>"] = "move_cursor_up",
				-- ['<key>'] = function(state, scroll_padding) ... end,
			},
		},
	},
	buffers = {
		follow_current_file = {
			enabled = true, -- This will find and focus the file in the active buffer every time
			--	            -- the current file is changed while the tree is open.
			leave_dirs_open = true, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
		},
		group_empty_dirs = true, -- when true, empty folders will be grouped together
		show_unloaded = true,
		window = {
			mappings = {
				["bd"] = "buffer_delete",
				["<bs>"] = "navigate_up",
				["."] = "set_root",
				["o"] = { "show_help", nowait=false, config = { title = "Order by", prefix_key = "o" }},
				["oc"] = { "order_by_created", nowait = false },
				["od"] = { "order_by_diagnostics", nowait = false },
				["om"] = { "order_by_modified", nowait = false },
				["on"] = { "order_by_name", nowait = false },
				["os"] = { "order_by_size", nowait = false },
				["ot"] = { "order_by_type", nowait = false },
			}
		},
	},
	git_status = {
		window = {
			position = "float",
			mappings = {
				["A"]  = "git_add_all",
				["gu"] = "git_unstage_file",
				["ga"] = "git_add_file",
				["gr"] = "git_revert_file",
				["gc"] = "git_commit",
				["gp"] = "git_push",
				["gg"] = "git_commit_and_push",
				["o"] = { "show_help", nowait=false, config = { title = "Order by", prefix_key = "o" }},
				["oc"] = { "order_by_created", nowait = false },
				["od"] = { "order_by_diagnostics", nowait = false },
				["om"] = { "order_by_modified", nowait = false },
				["on"] = { "order_by_name", nowait = false },
				["os"] = { "order_by_size", nowait = false },
				["ot"] = { "order_by_type", nowait = false },
			}
		}
	},
	document_symbols = {
		follow_cursor = false,
		client_filters = "first",
		renderers = {
			root = {
				{"indent"},
				{"icon", default="C" },
				{"name", zindex = 10},
			},
			symbol = {
				{"indent", with_expanders = true},
				{"kind_icon", default="?" },
				{"container",
				content = {
				  {"name", zindex = 10},
				  {"kind_name", zindex = 20, align = "right"},
				  }
				}
			},
		},
		window = {
			position = "right",
			mappings = {
				["<cr>"] = "jump_to_symbol",
				["o"] = "jump_to_symbol",
				["A"] = "noop", -- also accepts the config.show_path and config.insert_as options.
				["d"] = "noop",
				["i"] = "noop",
				["y"] = "noop",
				["x"] = "noop",
				["p"] = "noop",
				["c"] = "noop",
				["C"] = "noop",
				["m"] = "noop",
				["a"] = "noop",
				["<"] = "noop",
				[">"] = "noop",
				["/"] = "filter",
				["f"] = "filter_on_submit",
			},
		},
		custom_kinds = {
			-- define custom kinds here (also remember to add icon and hl group to kinds)
			-- ccls
			-- [252] = 'TypeAlias',
			-- [253] = 'Parameter',
			-- [254] = 'StaticMethod',
			-- [255] = 'Macro',
		},
		kinds = {
			Unknown = { icon = "?", hl = "" },
			Root = { icon = "", hl = "NeoTreeRootName" },
			File = { icon = "󰈙", hl = "Tag" },
			Module = { icon = "", hl = "Exception" },
			Namespace = { icon = "󰌗", hl = "Include" },
			Package = { icon = "󰏖", hl = "Label" },
			Class = { icon = "󰌗", hl = "Include" },
			Method = { icon = "", hl = "Function" },
			Property = { icon = "󰆧", hl = "@property" },
			Field = { icon = "", hl = "@field" },
			Constructor = { icon = "", hl = "@constructor" },
			Enum = { icon = "󰒻", hl = "@number" },
			Interface = { icon = "", hl = "Type" },
			Function = { icon = "󰊕", hl = "Function" },
			Variable = { icon = "", hl = "@variable" },
			Constant = { icon = "", hl = "Constant" },
			String = { icon = "󰀬", hl = "String" },
			Number = { icon = "󰎠", hl = "Number" },
			Boolean = { icon = "", hl = "Boolean" },
			Array = { icon = "󰅪", hl = "Type" },
			Object = { icon = "󰅩", hl = "Type" },
			Key = { icon = "󰌋", hl = "" },
			Null = { icon = "", hl = "Constant" },
			EnumMember = { icon = "", hl = "Number" },
			Struct = { icon = "󰌗", hl = "Type" },
			Event = { icon = "", hl = "Constant" },
			Operator = { icon = "󰆕", hl = "Operator" },
			TypeParameter = { icon = "󰊄", hl = "Type" },

			-- ccls
			-- TypeAlias = { icon = ' ', hl = 'Type' },
			-- Parameter = { icon = ' ', hl = '@parameter' },
			-- StaticMethod = { icon = '󰠄 ', hl = 'Function' },
			-- Macro = { icon = ' ', hl = 'Macro' },
		}
	},
})

vim.api.nvim_set_keymap("n", "<C-h>", ":Neotree toggle position=left<cr>", {
	silent = true,
	noremap = true
})

vim.api.nvim_set_keymap("n", "<C-d>", ":Neotree toggle document_symbols selector=false position=right<cr>", {
	silent = true,
	noremap = true
})
