local techfuncs = {}

function techfuncs.addRecipeUnlock(tech, rec)
	if not (data.raw.technology[tech] and data.raw.recipe[rec]) then
		return
	end
	if data.raw.technology[tech].effects then
		local found  = false
		for k, v in pairs(data.raw.technology[tech].effects) do
			if v.recipe == rec then
				found = true
				break
			end
		end
		if not found then
			table.insert(data.raw.technology[tech].effects, {type = "unlock-recipe", recipe = rec})
		end
	else
		data.raw.technology[tech].effects = {{type = "unlock-recipe", recipe = rec}}
	end
end

function techfuncs.removeRecipeUnlock(tech, rec)
	if not data.raw.technology[tech] then
		return
	end
	if data.raw.technology[tech].effects then
		for k, v in pairs(data.raw.technology[tech].effects) do
			if v.recipe == rec then
				data.raw.technology[tech].effects[k] = nil
				break
			end
		end
	end
end

function techfuncs.addPrereq(tech, prereq)
	if not (data.raw.technology[tech] and data.raw.technology[prereq]) then
		return
	end
	local pr = data.raw.technology[tech].prerequisites
	if pr then
		found = false
		for k, v in pairs(pr) do
			if v == prereq then
				found = true
				break
			end
		end
		if not found then
			table.insert(pr, prereq)
		end
	else
		data.raw.technology[tech].prerequisites = {prereq}
	end
end

function techfuncs.removePrereq(tech, prereq)
	--don't check for prereq tech's existence - the reason we're removing the requirement might be we've deleted it already!
	if not data.raw.technology[tech] then
		return
	end
	local pr = data.raw.technology[tech].prerequisites
	if pr then
		for k, v in pairs(pr) do
			if v == prereq then
				pr[k] = nil
				break
			end
		end
	end
end

function techfuncs.addSciencePackToDifficulty(tech, item)
	if tech then
		if tech.unit then
			if tech.unit.ingredients then
				local found = false
				for k, v in pairs(tech.unit.ingredients) do
					if v[1] == item or v["name"] == item then
						found = true
					end
				end
				if not found then
					table.insert(tech.unit.ingredients, {item, 1})
				end
			end
		else
			tech.unit.ingredients = {{item, 1}}
		end
	end
end

function techfuncs.addSciencePack(tech, item)
	if not (data.raw.technology[tech] and data.raw.tool[item]) then
		return
	end
	local t = data.raw.technology[tech]
	local n = t.normal
	local e = t.expensive
	techfuncs.addSciencePackToDifficulty(t, item)
	techfuncs.addSciencePackToDifficulty(n, item)
	techfuncs.addSciencePackToDifficulty(e, item)
end

function techfuncs.removeSciencePackFromDifficulty(tech, item)
	if tech then
		if tech.unit then
			if tech.unit.ingredients then
				for k, v in pairs(tech.unit.ingredients) do
					if v[1] == item or v["name"] == item then
						tech.unit.ingredients[k] = nil
						break
					end
				end
			end
		end
	end
end

function techfuncs.removeSciencePack(tech, item)
	if not (data.raw.technology[tech] and data.raw.tool[item]) then
		return
	end
	local t = data.raw.technology[tech]
	local n = t.normal
	local e = t.expensive
	techfuncs.removeSciencePackFromDifficulty(t, item)
	techfuncs.removeSciencePackFromDifficulty(n, item)
	techfuncs.removeSciencePackFromDifficulty(e, item)
end

return techfuncs
