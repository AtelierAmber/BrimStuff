local parts = {}
parts.green = settings.startup["brimstuff-greenhouse"].value
parts.waste = settings.startup["brimstuff-waste-treatment"].value
parts.oil_tol = settings.startup["brimstuff-toluene-from-oil"].value
parts.coke_tol = settings.startup["brimstuff-toluene-from-coke"].value

if mods["ThemTharHills"] then
  parts.acidwaste = "depleted-acid"
else
  parts.acidwaste = "chemical-waste"
end

parts.zinc = mods["BrassTacks-Updated"]
parts.steelValve = mods["IfNickel-Updated"] and settings.startup["ifnickel-steel-valve"].value
if parts.zinc then
  parts.brassExperiment = settings.startup["brasstacks-experimental-intermediates"].value
else
  parts.brassExperiment = false
end
parts.aai = mods["aai-industry"]

parts.motor = "motor"
if parts.aai then
  parts.motor = "electric-motor"
end

function parts.preferred(ingredients, quantities)
  for k, v in ipairs(ingredients) do
    if data.raw.item[v] then
      return {v, quantities[k]}
    end
  end
end

function parts.optionalIngredient(item, amount)
  if data.raw.item[item] then
    return {item, amount}
  end
end

if mods["bzfoundry"] and not settings.startup["bzfoundry-minimal"].value then
  parts.foundryEnabled = true
else
  parts.foundryEnabled = false
end

return parts
