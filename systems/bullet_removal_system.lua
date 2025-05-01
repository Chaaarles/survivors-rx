local Config = require "config"

local BulletRemovalSystem = Tiny.processingSystem()
BulletRemovalSystem.filter = Tiny.requireAll('bullet', 'pos')

function BulletRemovalSystem:process(entity, dt)
  -- Check if the bullet is outside the screen bounds
  if entity.pos.x < 0 or entity.pos.x > Config.window.width or
      entity.pos.y < 0 or entity.pos.y > Config.window.height then
    -- Remove the bullet from the world
    Tiny.removeEntity(self.world, entity)
  end
end

return BulletRemovalSystem
