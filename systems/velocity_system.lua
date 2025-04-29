local VelocitySystem = Tiny.processingSystem()
VelocitySystem.filter = Tiny.requireAll('vel', 'pos')

function VelocitySystem:process(entity, dt)
  -- Update position based on velocity
  entity.pos.x = entity.pos.x + entity.vel.x * dt
  entity.pos.y = entity.pos.y + entity.vel.y * dt
end

return VelocitySystem
