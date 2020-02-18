local S = minetest.get_translator("glooptest")
generation_ores = {}

function glooptest.ore_module.register_ore(modname, name, desc, uses)
	-- `desc` parameter is keep for backward compatibility
	-- newer uses of this function must not use this parameter and must
	-- set appropriate fully localized descriptions in `uses`.

	-- register block
	if uses.block ~= nil and uses.block.makes ~= false then
		minetest.register_node(modname..":"..name.."block", {
			-- Use fully localized description unless desc is set (backward compatibility)
			description = desc and (desc.." Block") or uses.block.desc,
			tiles = {uses.block.texture},
			is_ground_content = true,
			light_source = uses.block.light or 0,
			groups = uses.block.groups,
			sounds = uses.block.sounds
		})
		if uses.block.fromingots == true and uses.ingot ~= nil then
			minetest.register_craft({
				output = modname..":"..name.."block",
				recipe = {
					{modname..":"..name.."_ingot", modname..":"..name.."_ingot", modname..":"..name.."_ingot"},
					{modname..":"..name.."_ingot", modname..":"..name.."_ingot", modname..":"..name.."_ingot"},
					{modname..":"..name.."_ingot", modname..":"..name.."_ingot", modname..":"..name.."_ingot"}
				}
			})
			minetest.register_craft({
				output = modname..":"..name.."_ingot 9",
				recipe = {
					{modname..":"..name.."block"}
				}
			})
		end
	end
	-- register ore
	if uses.ore ~= nil and uses.ore.makes ~= false then
		minetest.register_node(modname..":mineral_"..name, {
			-- Use fully localized description unless desc is set (backward compatibility)
			description = desc and (desc.." Ore") or uses.ore.desc,
			tiles = {uses.ore.texture.base.."^"..uses.ore.texture.overlay},
			is_ground_content = true,
			drop = uses.ore.drop,
			light_source = uses.ore.light or 0,
			groups = uses.ore.groups,
			sounds = uses.ore.sounds
		})
		minetest.register_ore({
			ore_type       = "scatter",
			ore            = modname..":mineral_"..name,
			wherein        = uses.ore.generate.generate_inside_of,
			clust_scarcity = uses.ore.generate.chunks_per_mapblock,
			clust_num_ores = uses.ore.generate.max_blocks_per_chunk,
			clust_size     = uses.ore.generate.chunk_size,
			y_min     = uses.ore.generate.miny,
			y_max     = uses.ore.generate.maxy,
		})
	end
	-- register lump
	if uses.lump ~= nil and uses.lump.makes ~= false then
		minetest.register_craftitem(modname..":"..name.."_"..uses.lump.name, {
			-- Use fully localized description unless desc is set
			-- or uses.lump.desc is equals to "Lump" (backward compatibility)
			description = (uses.lump.desc == "Lump" or desc)
				and (desc.." "..uses.lump.desc) or uses.lump.desc,
			inventory_image = uses.lump.texture,
		})
	end
	-- register ingot
	if uses.ingot ~= nil and uses.ingot.makes ~= false then
		minetest.register_craftitem(modname..":"..name.."_ingot", {
			-- Use fully localized description unless desc is set (backward compatibility)
			description = desc and (desc.." Ingot") or uses.ingot.desc,
			inventory_image = uses.ingot.texture,
		})
		if uses.ingot.smeltrecipe == true and uses.lump ~= nil then
			minetest.register_craft({
				type = "cooking",
				output = modname..":"..name.."_ingot",
				recipe = modname..":"..name.."_"..uses.lump.name,
			})
		end
	end
	-- register tools
	if glooptest.modules.tools and (uses.tools ~= nil) and (uses.tools.makes ~= nil) then
		local u = {}
		for tool, value in pairs(uses.tools.makes) do
			u[tool].makes = value
			u[tool].texture = uses.tools.texture[tool] or nil
			u[tool].caps = uses.tools.caps[tool] or nil
			u[tool].desc = uses.tools.desc[tool] or nil
		end
		glooptest.tools_module.register_tools(modname, name, desc, u)
	end
end
