local S = minetest.get_translator("glooptest")
local use_toolranks = minetest.get_modpath("toolranks")

-- register new tool type for toolranks
if use_toolranks and minetest.get_modpath("toolranks_extras") and toolranks_extras.register_tool_type then
	toolranks_extras.register_tool_type("Handsaw", S("handsaw"))
	toolranks_extras.register_tool_type("Hammer", S("hammer"))
end

function glooptest.tools_module.set_tool_recipe(modname, type, material, name)
	if type == "sword" then
		minetest.register_craft({
			recipe = {{material},{material},{"default:stick"}},
			output = modname..":sword_"..name,
		})
	elseif type == "axe" then
		minetest.register_craft({
			recipe = {{material, material}, {material, "default:stick"}, {"","default:stick"}},
			output = modname..":axe_"..name,
		})
		minetest.register_craft({
			recipe = {{material, material}, {"default:stick", material}, {"default:stick", ""}},
			output = modname..":axe_"..name,
		})
	elseif type == "pick" or type == "pickaxe" then
		minetest.register_craft({
			recipe = {{material, material, material}, {"","default:stick",""}, {"","default:stick",""}},
			output = modname..":pick_"..name,
		})
	elseif type == "shovel" then
		minetest.register_craft({
			recipe = {{material},{"default:stick"},{"default:stick"}},
			output = modname..":shovel_"..name,
		})
	elseif type == "handsaw" then
		minetest.register_craft({
			recipe = {{material, "default:stick"},{material, "default:stick"},{"", "default:stick"}},
			output = modname..":handsaw_"..name,
		})
		minetest.register_craft({
			recipe = {{"default:stick", material},{"default:stick", material},{"default:stick", ""}},
			output = modname..":handsaw_"..name,
		})
	elseif type == "hammer" then
		minetest.register_craft({
			recipe = {{material, "default:stick", material}, {material, "default:stick", material}, {"", "default:stick", ""}},
			output = modname..":hammer_"..name,
		})
	end
end

function glooptest.tools_module.register_tools(modname, name, desc, material, uses)
	-- `desc` parameter is keep only for backward compatibility and must not be used
	-- with newer calls of this function. Use `uses` attribute containing fully localized description instead.
	-- register handsaw
	if uses.handsaw ~= nil and uses.handsaw.makes ~= false then
		-- Use fully localized description unless desc is set (backward compatibility)
		local d = desc and (desc.." Handsaw") or uses.handsaw.desc
		local original_description
		if use_toolranks then
			original_description = d
			d = toolranks.create_description(d)
		end
		minetest.register_tool(modname..":handsaw_"..name, {
			original_description = original_description or nil,
			description = d,
			inventory_image = uses.handsaw.texture,
			tool_capabilities = uses.handsaw.caps,
			after_use = use_toolranks and toolranks.new_afteruse or nil,
		})
		glooptest.tools_module.set_tool_recipe(modname,"handsaw",material,name)
	end
	-- register hammer
	if uses.hammer ~= nil and uses.hammer.makes ~= false then
		-- Use fully localized description unless desc is set (backward compatibility)
		local d = desc and (desc.." Hammer") or uses.hammer.desc
		local original_description
		if use_toolranks then
			original_description = d
			d = toolranks.create_description(d)
		end
		minetest.register_tool(modname..":hammer_"..name, {
			original_description = original_description or nil,
			description = d,
			inventory_image = uses.hammer.texture,
			tool_capabilities = uses.hammer.caps,
			after_use = use_toolranks and toolranks.new_afteruse or nil,
		})
		glooptest.tools_module.set_tool_recipe(modname,"hammer",material,name)
	end
	-- register sword
	if uses.sword ~= nil and uses.sword.makes ~= false then
		-- Use fully localized description unless desc is set (backward compatibility)
		local d = desc and (desc.." Sword") or uses.sword.desc
		local original_description
		if use_toolranks then
			original_description = d
			d = toolranks.create_description(d)
		end
		minetest.register_tool(modname..":sword_"..name, {
			original_description = original_description or nil,
			description = d,
			inventory_image = uses.sword.texture,
			tool_capabilities = uses.sword.caps,
			after_use = use_toolranks and toolranks.new_afteruse or nil,
		})
		glooptest.tools_module.set_tool_recipe(modname,"sword",material,name)
	end
	-- register axe
	if uses.axe ~= nil and uses.axe.makes ~= false then
		-- Use fully localized description unless desc is set (backward compatibility)
		local d = desc and (desc.." Sword") or uses.axe.desc
		local original_description
		if use_toolranks then
			original_description = d
			d = toolranks.create_description(d)
		end
		minetest.register_tool(modname..":axe_"..name, {
			original_description = original_description or nil,
			description = d,
			inventory_image = uses.axe.texture,
			tool_capabilities = uses.axe.caps,
			after_use = use_toolranks and toolranks.new_afteruse or nil,
		})
		glooptest.tools_module.set_tool_recipe(modname,"axe",material,name)
	end
	-- register pickaxe
	if uses.pick ~= nil and uses.pick.makes ~= false then
		-- Use fully localized description unless desc is set (backward compatibility)
		local d = desc and (desc.." Pickaxe") or uses.pick.desc
		local original_description
		if use_toolranks then
			original_description = d
			d = toolranks.create_description(d)
		end
		minetest.register_tool(modname..":pick_"..name, {
			original_description = original_description or nil,
			description = d,
			inventory_image = uses.pick.texture,
			tool_capabilities = uses.pick.caps,
			after_use = use_toolranks and toolranks.new_afteruse or nil,
		})
		glooptest.tools_module.set_tool_recipe(modname,"pick",material,name)
	end
	-- register shovel
	if uses.shovel ~= nil and uses.shovel.makes ~= false then
		-- Use fully localized description unless desc is set (backward compatibility)
		local d = desc and (desc.." Shovel") or uses.shovel.desc
		local original_description
		if use_toolranks then
			original_description = d
			d = toolranks.create_description(d)
		end
		minetest.register_tool(modname..":shovel_"..name, {
			original_description = original_description or nil,
			description = d,
			inventory_image = uses.shovel.texture,
			wield_image = uses.shovel.texture.."^[transformR90",
			tool_capabilities = uses.shovel.caps,
			after_use = use_toolranks and toolranks.new_afteruse or nil,
		})
		glooptest.tools_module.set_tool_recipe(modname,"shovel",material,name)
	end
end
