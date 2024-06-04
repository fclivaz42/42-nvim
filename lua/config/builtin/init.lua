--[[ Built-ins config loader. ]]--

local config = ... .. "."

-- Load Telescope Settings.
require(config .. "_telescope")

-- Load Treesitter Settings.
require(config .. "_treesitter")

-- Load LSP Settings.
require(config .. "_lsp")

-- Load Autocompletion Settings.
require(config .. "_cmp")

-- Load File Tree Settings.
require(config .. "_nvimtree")

-- Set theme.
require(config .. "_themeselect")
