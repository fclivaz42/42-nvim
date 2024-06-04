--[[ Config loader. ]]--

local config = ... .. "."

-- Load 42 settings.
require(config .. "42")

-- Load builtin configs
require(config .. "builtin")

-- Load custom configs
require(config .. "custom")
