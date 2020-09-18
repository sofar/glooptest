-- GloopTest general initiation file.
-- To edit what modules will load, please edit minetest.conf file.
--
-- GloopTest random data:
--    Version                             : 0.0.4a
--    Current module amount               : 6
--    Current compatible minetest version : 0.4.7
--    License                             : CC-BY-SA
--    Totals: lol I don't know
-- End random data.

-- Set up some variables and crap.
local modules_loaded = 0
glooptest = {}

-- export which modules are loaded
glooptest.modules = {
	compat = minetest.settings:get_bool("glooptest.load_compat_module", true),
	ore = minetest.settings:get_bool("glooptest.load_ore_module", true),
	tools = minetest.settings:get_bool("glooptest.load_tools_module", true),
	parts = minetest.settings:get_bool("glooptest.load_parts_module", true),
	tech = minetest.settings:get_bool("glooptest.load_module", true),
	othergen = minetest.settings:get_bool("glooptest.load_module", true),
}

-- Set up some general functions for random crap.
function glooptest.debug(level,message)
	print("["..level.."][GloopTest v0.0.4a] "..message)
end

if glooptest.modules.ore then
	dofile(minetest.get_modpath("glooptest").."/ore_module/init.lua")
	local modulecount = modules_loaded
	modules_loaded = modulecount+1
end

if glooptest.modules.tools then
	dofile(minetest.get_modpath("glooptest").."/tools_module/init.lua")
	local modulecount = modules_loaded
	modules_loaded = modulecount+1
end

if glooptest.modules.parts then
	dofile(minetest.get_modpath("glooptest").."/parts_module/init.lua")
	local modulecount = modules_loaded
	modules_loaded = modulecount+1
end

if glooptest.modules.tech then
	dofile(minetest.get_modpath("glooptest").."/tech_module/init.lua")
	local modulecount = modules_loaded
	modules_loaded = modulecount+1
end

if glooptest.modules.othergen then
	dofile(minetest.get_modpath("glooptest").."/othergen_module/init.lua")
	local modulecount = modules_loaded
	modules_loaded = modulecount+1
end

if glooptest.modules.compat then
	dofile(minetest.get_modpath("glooptest").."/compat_module/init.lua")
	local modulecount = modules_loaded
	modules_loaded = modulecount+1
end

if modules_loaded == 0 then
	glooptest.debug("ERROR","It helps if you activate some of the modules.")
else
	glooptest.debug("MESSAGE",modules_loaded.." modules were successfully loaded!")
end
