local parts = require("variable-parts")
local tf = require("techfuncs")
local rm = require("recipe-modify")
local cu = require("category-utils")

local gasket_item = "rubber"
local gasket_ratio = 2
if mods["BrassTacks"] then
  gasket_item = "airtight-seal"
  gasket_ratio = 1
else if mods["bzcarbon"] then
  gasket_item = "gasket"
  gasket_ratio = 1
end end

if mods["248k"] then
  if not mods["IfNickel"] then
    rm.AddIngredient("fu_burner_recipe", gasket_item, 5 * gasket_ratio, 5 * gasket_ratio)
    rm.ReplaceProportional("el_grower_recipe", "iron-gear-wheel", gasket_item, gasket_ratio)
    rm.AddIngredient("el_burner_kerosene_recipe", gasket_item, 5 * gasket_ratio, 5 * gasket_ratio)
    rm.AddIngredient("el_pressurizer_recipe", gasket_item, 10 * gasket_ratio, 10 * gasket_ratio)
    rm.AddIngredient("fi_refinery_recipe", gasket_item, 20 * gasket_ratio, 20 * gasket_ratio)
    rm.AddIngredient("fu_turbine_recipe", gasket_item, 20 * gasket_ratio, 20 * gasket_ratio)
    rm.AddIngredient("fu_boiler_recipe", gasket_item, 20 * gasket_ratio, 20 * gasket_ratio)
    rm.AddIngredient("fu_exchanger_item_recipe", gasket_item, 20 * gasket_ratio, 20 * gasket_ratio)
  end
end
