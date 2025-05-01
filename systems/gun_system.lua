local Bullet = require "entities.tiny_bullet"

local GunSystem = Tiny.processingSystem()
GunSystem.filter = Tiny.requireAll("gun")

local gunSounds = {
  love.audio.newSource("assets/audio/gun1.mp3", "static"),
  love.audio.newSource("assets/audio/gun2.mp3", "static"),
  love.audio.newSource("assets/audio/gun3.mp3", "static"),
  love.audio.newSource("assets/audio/gun4.mp3", "static"),
}

local function playRandomGunSound()
  local sound = gunSounds[math.random(1, #gunSounds)]

  if sound:isPlaying() then
    sound = sound:clone()
  end

  sound:setVolume(0.1)
  sound:setPitch(1 + math.random() * 0.2 - 0.1) -- Random pitch variation
  sound:stop()
  sound:play()
end

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

    -- Play gun sound
    playRandomGunSound()
  end
end

function GunSystem:findClosestEnemy(x, y)
  local closestEnemy = nil
  local closestDistance = math.huge

  for _, enemy in ipairs(self.world.entities) do
    if not enemy.enemy then
    else
      local distance = math.sqrt((enemy.pos.x - x) ^ 2 + (enemy.pos.y - y) ^ 2)
      if distance < closestDistance then
        closestDistance = distance
        closestEnemy = enemy
      end
    end
  end

  return closestEnemy
end

return GunSystem
