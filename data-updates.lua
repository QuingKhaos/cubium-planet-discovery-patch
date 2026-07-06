local khaoslib_technology = require("__khaoslib__.technology")
local technology_or = require("__technology_or__.technology_or")

local cubium = khaoslib_technology:load("planet-discovery-cubium")

if mods["AsteroidBelt"] then
  cubium:add_prerequisite("space-discovery-asteroid-belt")
    :commit()
else
  local desc = {localised_description = {"technology-description.planet-discovery-cubium-multiple-routes"}}

  cubium:copy("planet-discovery-cubium-vulcanus")
    :set(desc)
    :clear_prerequisites()
    :add_prerequisite("metallurgic-science-pack")
    :add_science_pack({"metallurgic-science-pack", 1})
    :remove_effect(function(effect)
      return effect.type ~= "unlock-space-location"
    end, {all = true})
    :commit()

  cubium:copy("planet-discovery-cubium-gleba")
    :set(desc)
    :clear_prerequisites()
    :add_prerequisite("agricultural-science-pack")
    :add_science_pack({"agricultural-science-pack", 1})
    :remove_effect(function(effect)
        return effect.type ~= "unlock-space-location"
      end, {all = true})
    :commit()

  local cube_basics = technology_or.OR({"planet-discovery-cubium-vulcanus", "planet-discovery-cubium-gleba"}, true)
  khaoslib_technology:load(cube_basics)
    :unset("icons")
    :set {icon = data.raw["technology"]["cube-jelly"].icon, icon_size = data.raw["technology"]["cube-jelly"].icon_size}
    :set {localised_name = {"technology-name.OR-planet-discovery-cubium"}}
    :set {localised_description = {"technology-description.OR-planet-discovery-cubium"}}
    :set {effects = data.raw["technology"]["planet-discovery-cubium"].effects}
    :remove_effect(function(effect)
      return effect.type == "unlock-space-location"
    end, {all = true})
    :commit()

  khaoslib_technology:load("cube-jelly")
    :clear_prerequisites()
    :add_prerequisite(cube_basics.name)
    :commit()

  cubium:remove()
end
