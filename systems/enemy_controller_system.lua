local EnemyControllerSystem = Tiny.processingSystem()
EnemyControllerSystem.filter = Tiny.requireAll('enemy', 'pos', 'vel', 'speed', 'hitState')

function EnemyControllerSystem:process(entity, dt)
  -- Simple AI logic to move towards the player
  if entity.hitState > 0 then
    -- Skips processing if the entity is in a hit state.
    return
  end

  if PLAYER then
    local dx = PLAYER.pos.x - entity.pos.x
    local dy = PLAYER.pos.y - entity.pos.y
    local distance = math.sqrt(dx * dx + dy * dy)

    if distance > 0 then
      dx = dx / distance
      dy = dy / distance

      entity.vel.x = entity.vel.x + dx * entity.speed.acceleration
      entity.vel.y = entity.vel.y + dy * entity.speed.acceleration
    end
  end
end

return EnemyControllerSystem
