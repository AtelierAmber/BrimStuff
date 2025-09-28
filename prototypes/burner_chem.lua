local parts = require("variable-parts")
local util = require("util")

data:extend({
  {
    type = "recipe-category",
    name = "basic-chemistry"
  }
})

if mods["bzgas"] and not settings.startup["brimstuff-clobber-bz-chemical-plant"].value then
  data.raw["assembling-machine"]["basic-chemical-plant"].crafting_categories = {"basic-chemistry"}
  return
end

local bcp_icon = {
  {
    icon = "__base__/graphics/icons/chemical-plant.png",
    icon_size = 64, icon_mipmaps = 4,
    tint = {0.5, 0.5, 0.5, 1}
  },
  {
    icon = "__core__/graphics/arrows/heat-exchange-indication.png",
    icon_size = 48, icon_mipmaps = 4,
    scale = 0.5,
    shift = {6, 6}
  }
}

local bcp = util.table.deepcopy(data.raw["assembling-machine"]["chemical-plant"])

bcp.name = "basic-chemical-plant"
bcp.order = "dz"
bcp.icon = nil
bcp.icons = bcp_icon
bcp.fluid_boxes = {
  {
    production_type = "input",
    pipe_picture = assembler3pipepictures(),
    pipe_covers = pipecoverspictures(),
    base_area = 10,
    base_level = -1,
    pipe_connections = {{ type="input", position = {0, -2} }},
    secondary_draw_orders = { north = -1, west = -1 }
  },
  {
    production_type = "output",
    pipe_picture = assembler3pipepictures(),
    pipe_covers = pipecoverspictures(),
    base_area = 1,
    base_level = 1,
    pipe_connections = {{ type="output", position = {0, 2} }},
    secondary_draw_orders = { north = -1, west = -1 }
  }
}

bcp.minable.result="basic-chemical-plant"
bcp.crafting_categories={"basic-chemistry"}

bcp.animation = {
  layers =
  {
    {
      filename = "__BrimStuff__/graphics/entity/burnerchem.png",
      priority = "high",
      width = 116,
      height = 93,
      frame_count = 1,
      line_length = 1,
      shift = util.by_pixel(10.5, 3)
    },
    {
      filename = "__BrimStuff__/graphics/entity/burnerchem_shadow.png",
      priority = "high",
      width = 116,
      height = 93,
      frame_count = 1,
      line_length = 1,
      shift = util.by_pixel(10.5, 3),
      draw_as_shadow = true
    },
    {
      filename = "__base__/graphics/entity/steel-furnace/steel-furnace.png",
      priority="high",
      x = 31,
      y = 56,
      width = 27,
      height = 14,
      frame_count = 1,
      line_length = 1,
      shift = util.by_pixel(-1.5, 12.9),
      tint = {0.5,0.5,0.5,1},
      hr_version =
      {
        filename = "__base__/graphics/entity/steel-furnace/hr-steel-furnace.png",
        priority="high",
        x = 62,
        y = 112,
        width = 54,
        height = 28,
        frame_count = 1,
        line_length = 1,
        shift = util.by_pixel(-1.5, 12.9),
        tint = {0.5,0.5,0.5,1},
        scale = 0.5
      }
    }
  }
}

bcp.working_visualisations = util.table.deepcopy(data.raw.furnace["steel-furnace"].working_visualisations)
--lua y u no have plus equals
bcp.working_visualisations[1].animation.shift[1] = bcp.working_visualisations[1].animation.shift[1] - 1/16
bcp.working_visualisations[1].animation.hr_version.shift[1] = bcp.working_visualisations[1].animation.hr_version.shift[1] - 1/16
bcp.working_visualisations[1].animation.shift[2] = bcp.working_visualisations[1].animation.shift[2] - 1/4
bcp.working_visualisations[1].animation.hr_version.shift[2] = bcp.working_visualisations[1].animation.hr_version.shift[2] - 1/4
bcp.working_visualisations[1].animation.animation_speed = 2
bcp.working_visualisations[1].animation.hr_version.animation_speed = 2

bcp.working_visualisations[2].animation.shift[1] = bcp.working_visualisations[2].animation.shift[1] - 1/16
bcp.working_visualisations[2].animation.shift[2] = bcp.working_visualisations[2].animation.shift[2] - 1/4

bcp.working_visualisations[4].animation.shift[1] = bcp.working_visualisations[4].animation.shift[1] - 1/16
bcp.working_visualisations[4].animation.hr_version.shift[1] = bcp.working_visualisations[4].animation.hr_version.shift[1] - 1/16
bcp.working_visualisations[4].animation.shift[2] = bcp.working_visualisations[4].animation.shift[2] - 1/4
bcp.working_visualisations[4].animation.hr_version.shift[2] = bcp.working_visualisations[4].animation.hr_version.shift[2] - 1/4


bcp.working_visualisations[3] = nil

bcp.working_visualisations[5] = {
      apply_recipe_tint = "tertiary",
      fadeout = true,
      constant_speed = true,
      render_layer = "wires",
      animation =
      {
        filename = "__base__/graphics/entity/chemical-plant/chemical-plant-smoke-outer.png",
        frame_count = 47,
        line_length = 16,
        width = 46,
        height = 94,
        animation_speed = 0.5,
        shift = util.by_pixel(-2, -75),
        hr_version =
        {
          filename = "__base__/graphics/entity/chemical-plant/hr-chemical-plant-smoke-outer.png",
          frame_count = 47,
          line_length = 16,
          width = 90,
          height = 188,
          animation_speed = 0.5,
          shift = util.by_pixel(-2, -75),
          scale = 0.5
        }
      }
    }

bcp.working_visualisations[6] = {
        apply_recipe_tint = "quaternary",
        fadeout = true,
        constant_speed = true,
        render_layer = "wires",
        animation =
        {
          filename = "__base__/graphics/entity/chemical-plant/chemical-plant-smoke-inner.png",
          frame_count = 47,
          line_length = 16,
          width = 20,
          height = 42,
          animation_speed = 0.5,
          shift = util.by_pixel(-2, -49),
          hr_version =
          {
            filename = "__base__/graphics/entity/chemical-plant/hr-chemical-plant-smoke-inner.png",
            frame_count = 47,
            line_length = 16,
            width = 40,
            height = 84,
            animation_speed = 0.5,
            shift = util.by_pixel(-2, -49),
            scale = 0.5
          }
        }
      }

bcp.crafting_speed = 0.5
bcp.module_specification = nil
bcp.allowed_effects = nil
bcp.energy_source =
    {
      type = "burner",
      fuel_category = "chemical",
      effectivity = 1,
      emissions_per_minute = 5,
      fuel_inventory_size = 1,
      light_flicker = {color = {0,0,0}},
      smoke =
      {
        {
          name = "smoke",
          deviation = {0.1, 0.1},
          frequency = 9,
          position = {0, 0.2}
        }
      }
    }
bcp.energy_usage = "180kW"

data:extend({
  bcp,
  {
    type = "item",
    name = "basic-chemical-plant",
    icons = bcp_icon,
    subgroup = "production-machine",
    place_result = "basic-chemical-plant",
    order = "dz",
    stack_size = 10
  },
  {
    type = "recipe",
    name = "basic-chemical-plant",
    category = "crafting",
    energy_required = 1,
    result = "basic-chemical-plant",
    enabled = false,
    ingredients = {parts.preferred({"silver-plate", "aluminum-plate", "iron-plate"}, {5, 5, 5}), {"iron-gear-wheel", 5}, {"pipe", 5}}
  }
})
