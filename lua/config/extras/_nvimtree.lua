--[[ NvimTree configuration ]]--

local function open_nvim_tree()
	-- open the tree
	require("nvim-tree.api").tree.open()
end

-- sets CTRL-H as the keybind to hide-show NvimTree.
vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })
vim.api.nvim_set_keymap("n", "<C-h>", ":NvimTreeToggle<cr>", {silent = true, noremap = true})

local nt_api = require'nvim-tree.api'

nt_api.events.subscribe(nt_api.events.Event.TreeOpen, function()
  local tree_winid = nt_api.tree.winid()
  if tree_winid ~= nil then
    vim.api.nvim_set_option_value('statusline', '%t', {scope = 'local', win = tree_winid})
  end
end)

require("nvim-tree").setup({
	sort_by = "case_sensitive",
	view = {
		width = 32,
	},
	renderer = {
		group_empty = true,
	},
	filters = {
		dotfiles = true,
	},
})

