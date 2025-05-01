local Input = require('input')

local PlayerControllerSystem = Tiny.processingSystem()
PlayerControllerSystem.filter = Tiny.requireAll('playerController')

function PlayerControllerSystem:process(entity, dt)
  local dx, dy = 0, 0
  if Input.left then dx = dx - 1 end
  if Input.right then dx = dx + 1 end
  if Input.up then dy = dy - 1 end
  if Input.down then dy = dy + 1 end

  if dx ~= 0 and dy ~= 0 then
    local normalizeFactor = 1 / math.sqrt(2)
    dx = dx * normalizeFactor
    dy = dy * normalizeFactor
  end

  entity.vel.x = entity.vel.x + dx * entity.speed.acceleration * dt
  entity.vel.y = entity.vel.y + dy * entity.speed.acceleration * dt

  -- Clamp velocity to max speed
  local speed = math.sqrt(entity.vel.x * entity.vel.x + entity.vel.y * entity.vel.y)
  if speed > entity.speed.max then
    entity.vel.x = (entity.vel.x / speed) * entity.speed.max
    entity.vel.y = (entity.vel.y / speed) * entity.speed.max
  end
end

return PlayerControllerSystem
