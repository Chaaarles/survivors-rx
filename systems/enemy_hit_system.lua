local EnemyHitSystem  = Tiny.processingSystem()
EnemyHitSystem.filter = Tiny.requireAll("enemy", "pos", "vel", "hitBy", "hitState", "health")
local config          = require("config")

local slapSound       = love.audio.newSource("assets/audio/slap.mp3", "static")
local deadSound       = love.audio.newSource("assets/audio/au.mp3", "static")

local function playSound(sound, seek)
  seek = seek or 0
  if sound:isPlaying() then
    sound = sound:clone()
  end

  sound:setVolume(1)
  sound:setPitch(1 + math.random() * 0.2 - 0.1) -- Random pitch variation
  sound:stop()
  sound:seek(seek)
  sound:play()
end

function EnemyHitSystem:process(entity, dt)
  if entity.hitBy.x ~= nil then
    local hitBy = entity.hitBy
    local knockback = config.combat.knockback

    -- Calculate the knockback direction
    local magnitude = math.sqrt(hitBy.x * hitBy.x + hitBy.y * hitBy.y)
    local dx = hitBy.x / magnitude
    local dy = hitBy.y / magnitude

    -- Apply knockback effect
    entity.vel.x = entity.vel.x + dx * knockback
    entity.vel.y = entity.vel.y + dy * knockback

    -- Set the hit state to indicate the enemy is hit
    entity.hitState = 0.3

    -- Reduce health
    entity.health = entity.health - 1
    if entity.health <= 0 then
      -- Handle enemy death (e.g., remove the entity)
      Tiny.removeEntity(self.world, entity)
      -- Play dead sound
      playSound(deadSound, 0.3)
    end

    -- Remove the hitBy reference to prevent repeated knockback
    entity.hitBy = { x = nil, y = nil }

    -- Play slap sound
    playSound(slapSound, 0.05)
  end
end

return EnemyHitSystem
