local Input = require "input"
local Bullet = require "entities.tiny_bullet"
local config = require "config"

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
    local dx, dy = 0, 0
    if Input.shoot.left then dx = dx - 1 end
    if Input.shoot.right then dx = dx + 1 end
    if Input.shoot.up then dy = dy - 1 end
    if Input.shoot.down then dy = dy + 1 end

    if dx == 0 and dy == 0 then
      return -- No shooting direction
    end

    if dx ~= 0 and dy ~= 0 then
      local normalizeFactor = 1 / math.sqrt(2)
      dx = dx * normalizeFactor
      dy = dy * normalizeFactor
    end

    local xVel, yVel = dx * config.bullet.speed, dy * config.bullet.speed

    xVel = xVel + PLAYER.vel.x * 0.5
    yVel = yVel + PLAYER.vel.y * 0.5

    -- Create a bullet and add it to the world
    local bullet = Bullet.new(PLAYER.pos.x, PLAYER.pos.y, xVel, yVel)
    Tiny.addEntity(self.world, bullet)
    entity.cooldown = entity.cooldownTime

    -- Play gun sound
    playRandomGunSound()
  end
end

return GunSystem
