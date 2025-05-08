local HitSystem = Tiny.processingSystem()
HitSystem.filter = Tiny.requireAll("hitBuffer", "health", "vel")

local play_sound = require("util.play_sound")

local Handlers = {
  damage = function(entity, damageEffect)
    entity.health.value = entity.health.value - damageEffect.value
  end,
  knockback = function(entity, knockbackEffect)
    entity.vel.x = entity.vel.x + knockbackEffect.x
    entity.vel.y = entity.vel.y + knockbackEffect.y
  end,
  stun = function(entity, stunEffect)
    entity.stun.value = stunEffect.duration
  end,
  invulnerable = function(entity, invulnerableEffect)
    entity.invulnerable.value = invulnerableEffect.duration
  end,
  sound = function(entity, soundEffect)
    local sound = soundEffect.sound
    play_sound(sound, soundEffect.seek or 0, soundEffect.volume or 1, soundEffect.pitch_variance or 0)
  end,
}

function HitSystem:process(entity, dt)
  if entity.hitBuffer == nil or #entity.hitBuffer == 0 then
    return
  end
  if entity.invulnerable ~= nil and entity.invulnerable.value > 0 then
    entity.hitBuffer = {}
    return
  end

  for _, hit in ipairs(entity.hitBuffer) do
    if hit.source and hit.effects then
      for _, effect in ipairs(hit.effects) do
        local handler = Handlers[effect.type]
        if handler then
          handler(entity, effect)
        end
      end
      if entity.invulnerable ~= nil and entity.invulnerable.value > 0 then
        break
      end
    end
  end

  entity.hitBuffer = {}
end

return HitSystem
