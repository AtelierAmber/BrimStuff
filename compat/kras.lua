local rm = require("recipe-modify")
local tf = require("techfuncs")
local parts = require("variable-parts")

local gasket = "rubber"
local gasket_cost = 2
if mods["bzcarbon"] and not mods["BrassTacks"] then
  gasket = "gasket"
  gasket_cost = 1
end

local airseal = false
local airseal_cost = 1
if not mods["IfNickel"] then
  if mods["BrassTacks"] then
    airseal = "airtight-seal"
  else
    airseal = gasket
    airseal_cost = gasket_cost
  end
end

if mods["advanced-chemical-plant"] and not mods["Krastorio2"] then
  if not (mods["BrassTacks"] or mods["IfNickel"]) then
    if not mods["ThemTharHills"] then
      rm.AddIngredient("kr-advanced-chemical-plant", "engine-unit", 8, 8) --galaxy brain
    end
    rm.AddIngredient("kr-advanced-chemical-plant", gasket, 32*gasket_cost, 32*gasket_cost)
  end
end

if mods["AdvancedAssemblyMachineStandalone"] and not mods["Krastorio2"] then
  if rm.CheckIngredient("assembling-machine-3", "electric-engine-unit") then
    rm.AddIngredient("kr-advanced-assembling-machine", "drive-belt", 24, 24)
  end
end

if mods["advanced-centrifuge"] then
  rm.AddIngredient("k11-advanced-centrifuge", "drive-belt", 20, 20)
end

if mods["Krastorio2"] then
  if parts.waste then
    rm.AddProductRaw("ammonia-from-potassium-nitrate", {type="fluid", name="chemical-waste", amount=10})
    rm.AddProductRaw("imersite-crystal", {type="fluid", name=parts.acidwaste, amount=20})

    if not mods["space-exploration"] then
      rm.AddProductRaw("ai-core", {type="fluid", name=parts.acidwaste, amount=10})

    end
  end

  if parts.waste and mods["ThemTharHills"] then
    rm.AddProductRaw("empty-antimatter-fuel-cell", {type="fluid", name=parts.acidwaste, amount=50})
    rm.AddProductRaw("kr-advanced-solar-panel", {type="fluid", name=parts.acidwaste, amount=25})
  end

  if not mods["ThemTharHills"] then
    tf.addRecipeUnlock("kr-advanced-chemistry", "ammonia-from-potassium-nitrate")
  end

  rm.ReplaceIngredient("pollution-filter", "plastic-bar", "rubber", 1, 1)

  if not mods["BrassTacks"] then
    rm.AddIngredient("kr-steel-pump", gasket, 2*gasket_cost, 2*gasket_cost)
    rm.AddIngredient("rocket-fuel-with-ammonia", gasket, gasket_cost, gasket_cost)
    rm.AddIngredient("rocket-fuel-with-hydrogen-chloride", gasket, gasket_cost, gasket_cost)
  end

  if not mods["IfNickel"] then
    rm.AddIngredient("kr-electrolysis-plant", airseal, 5*airseal_cost, 5*airseal_cost)
    rm.AddIngredient("kr-filtration-plant", airseal, 5*airseal_cost, 5*airseal_cost)
    rm.AddIngredient("kr-atmospheric-condenser", airseal, 5*airseal_cost, 5*airseal_cost)
    rm.AddIngredient("kr-fuel-refinery", airseal, 5*airseal_cost, 5*airseal_cost)
    tf.addPrereq("kr-fluids-chemistry", "rubber")
  end

  rm.AddIngredient("fuel-1", "toluene", 1, 1)
  rm.RemoveIngredient("fuel-1", "light-oil", 10, 10)
end

if mods["FluidMustFlow"] then
  rm.AddIngredient("duct-t-junction", gasket, 3*gasket_cost, 3*gasket_cost)
  rm.AddIngredient("duct-curve", gasket, 2*gasket_cost, 2*gasket_cost)
  rm.AddIngredient("duct-cross", gasket, 4*gasket_cost, 4*gasket_cost)
  rm.AddIngredient("duct-underground", gasket, 2*gasket_cost, 2*gasket_cost)
  if not mods["IfNickel"] then
    rm.AddIngredient("non-return-duct", gasket, 2*gasket_cost, 2*gasket_cost)
    if not mods["BrassTacks"] then
      rm.AddIngredient("duct-end-point-intake", gasket, 6*gasket_cost, 6*gasket_cost)
      rm.AddIngredient("duct-end-point-outtake", gasket, 6*gasket_cost, 6*gasket_cost)
    end
  end
end
