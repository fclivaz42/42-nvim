--[[ Custom plugin config loader. ]]--

local custom = ... .. "."

-- NOTE: In those files, you would load the settings of a plugin called 'time' and a plugin called 'space' respectively.
--
-- NOTE: in order to load your plugins, you must put
-- 'require(custom .. "myplugin")'
-- for every lua file that you have.
-- eg. if you have a file called time.lua and a file called space.lua, you would put:
-- require(custom .. "time")
-- require(custom .. "space")
-- I personally recommend prepending "_" to your config files to differentiate from the init.lua.
