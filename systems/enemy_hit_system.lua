local EnemyHitSystem = Tiny.processingSystem()
EnemyHitSystem.filter = Tiny.requireAll("enemy", "pos", "vel", "hitBy", "hitState", "health")

function EnemyHitSystem:process(entity, dt)
  if entity.hitBy.x ~= nil then
    local hitBy = entity.hitBy
    local knockback = 400

    -- Calculate the knockback direction
    local magnitude = math.sqrt(hitBy.x * hitBy.x + hitBy.y * hitBy.y)
    local dx = hitBy.x / magnitude
    local dy = hitBy.y / magnitude

    -- Apply knockback effect
    entity.vel.x = entity.vel.x + dx * knockback
    entity.vel.y = entity.vel.y + dy * knockback

    -- Set the hit state to indicate the enemy is hit
    entity.hitState = 0.2

    -- Reduce health
    entity.health = entity.health - 1
    if entity.health <= 0 then
      -- Handle enemy death (e.g., remove the entity)
      Tiny.removeEntity(self.world, entity)
    end

    -- Remove the hitBy reference to prevent repeated knockback
    entity.hitBy = { x = nil, y = nil }
  end
end

return EnemyHitSystem
