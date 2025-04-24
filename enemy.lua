local Config = require "config"

local Enemy = {}
Enemy.__index = Enemy


function Enemy.new(x, y)
  local self     = setmetatable({}, Enemy)
  self.x, self.y = x, y
  self.radius    = Config.enemy.radius
  self.speed     = Config.enemy.speed
  return self
end

function Enemy:update(dt, player)
  local dx = player.x - self.x
  local dy = player.y - self.y
  local distance = math.sqrt(dx * dx + dy * dy)

  if distance > 0 then
    dx = dx / distance
    dy = dy / distance
  end

  self.x = self.x + dx * self.speed * dt
  self.y = self.y + dy * self.speed * dt
end

function Enemy:draw()
  love.graphics.setColor(1, 0.5, 0.5)
  love.graphics.circle("fill", self.x, self.y, self.radius)
end

return Enemy
