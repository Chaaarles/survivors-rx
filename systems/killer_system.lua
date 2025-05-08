local KillerSystem  = Tiny.processingSystem()
KillerSystem.filter = Tiny.requireAll("health")
local play_sound    = require("util.play_sound")

local deadSound     = love.audio.newSource("assets/audio/au.mp3", "static")

function KillerSystem:process(entity, dt)
  if entity.health.value > 0 then return end

  -- Handle entity death (e.g., remove the entity)
  Tiny.removeEntity(self.world, entity)
  -- Play dead sound
  play_sound(deadSound, 0.3, 1, 0.2)
end

return KillerSystem
