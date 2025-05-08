local EnemyVelocityClampSystem = Tiny.processingSystem()
EnemyVelocityClampSystem.filter = Tiny.requireAll('enemy', 'vel', 'speed', 'stun')

function EnemyVelocityClampSystem:process(entity, dt)
  if (entity.stun.value > 0) then
    -- Skips processing if the entity is in a hit state.
    -- Knockback should not be clamped.
    return
  end

  local speed = math.sqrt(entity.vel.x * entity.vel.x + entity.vel.y * entity.vel.y)
  if speed > entity.speed.max then
    -- Normalize the velocity vector and scale it to the max speed
    local normalizeFactor = entity.speed.max / speed
    entity.vel.x = entity.vel.x * normalizeFactor
    entity.vel.y = entity.vel.y * normalizeFactor
  end
end

return EnemyVelocityClampSystem
