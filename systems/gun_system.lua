local Bullet = require "entities.tiny_bullet"

local GunSystem = Tiny.processingSystem()
GunSystem.filter = Tiny.requireAll("gun")

function GunSystem:process(entity, dt)
  if entity.cooldown > 0 then
    entity.cooldown = entity.cooldown - dt
  else
    local closestEnemy = self:findClosestEnemy(PLAYER.pos.x, PLAYER.pos.y)
    if not closestEnemy then
      return
    end

    local angle = 0
    if closestEnemy then
      local dx = closestEnemy.pos.x - PLAYER.pos.x
      local dy = closestEnemy.pos.y - PLAYER.pos.y
      angle = math.atan2(dy, dx)
    end

    -- Create a bullet and add it to the world
    local bullet = Bullet.new(PLAYER.pos.x, PLAYER.pos.y, angle)
    Tiny.addEntity(self.world, bullet)
    entity.cooldown = entity.cooldownTime
  end
end

function GunSystem:findClosestEnemy(x, y)
  local closestEnemy = nil
  local closestDistance = math.huge

  for _, enemy in ipairs(self.world.entities) do
    if not enemy.enemy then
      goto continue
    end
    local distance = math.sqrt((enemy.pos.x - x) ^ 2 + (enemy.pos.y - y) ^ 2)
    if distance < closestDistance then
      closestDistance = distance
      closestEnemy = enemy
    end
    ::continue::
  end

  return closestEnemy
end

return GunSystem
