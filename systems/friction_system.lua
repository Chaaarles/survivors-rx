local FrictionSystem = Tiny.processingSystem()
FrictionSystem.filter = Tiny.requireAll('vel', 'friction')

local minVelocity = 0.01

function FrictionSystem:process(entity, dt)
  -- Apply friction to velocity
  entity.vel.x = entity.vel.x * (1 - entity.friction * dt)
  entity.vel.y = entity.vel.y * (1 - entity.friction * dt)

  -- Clamp velocity to a minimum value to prevent it from becoming too small

  if math.abs(entity.vel.x) < minVelocity then
    entity.vel.x = 0
  end
  if math.abs(entity.vel.y) < minVelocity then
    entity.vel.y = 0
  end
end

return FrictionSystem
