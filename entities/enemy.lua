local Config = require "config"
local World = require "world"

local Enemy = {}
Enemy.__index = Enemy


function Enemy.new(x, y)
  local self     = setmetatable({}, Enemy)
  self.tag       = "enemy"
  self.x, self.y = x, y
  self.radius    = Config.enemy.radius
  self.speed     = Config.enemy.speed
  self.health    = Config.enemy.health
  return self
end

function Enemy:hurt()
  self.hurtAnimation = true
  self.hurtTime = 0.5

  self.health = self.health - 1
  if self.health <= 0 then
    self.removal = true
  end
end

function Enemy:update(dt)
  local world = World.getInstance()
  local dx = world.player.x - self.x
  local dy = world.player.y - self.y
  local distance = math.sqrt(dx * dx + dy * dy)

  if distance > 0 then
    dx = dx / distance
    dy = dy / distance
  end

  self.x = self.x + dx * self.speed * dt
  self.y = self.y + dy * self.speed * dt

  if self.hurtAnimation then
    self.hurtTime = self.hurtTime - dt
    if self.hurtTime <= 0 then
      self.hurtAnimation = false
    end
  end
end

function Enemy:draw()
  love.graphics.setColor(1, 0.5, 0.5)
  love.graphics.circle("fill", self.x, self.y, self.radius)

  if self.hurtAnimation then
    love.graphics.setColor(1, 0, 0)
    love.graphics.circle("fill", self.x, self.y, self.radius * 1.2)
    love.graphics.setColor(1, 0.5, 0.5)
  end
end

return Enemy
