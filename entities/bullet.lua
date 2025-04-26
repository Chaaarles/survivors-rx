local Config = require "config"

local Bullet = {}
Bullet.__index = Bullet

function Bullet.new(x, y, target)
  local self = setmetatable({}, Bullet)
  self.tag = "bullet"
  self.x, self.y = x, y
  self.radius = Config.bullet.radius
  self.speed = Config.bullet.speed
  self.life = Config.bullet.life
  self.removal = false

  -- Calculate the direction vector towards the target
  local dx = target.x - x
  local dy = target.y - y
  local length = math.sqrt(dx * dx + dy * dy)

  if length > 0 then
    self.vx = (dx / length) * self.speed
    self.vy = (dy / length) * self.speed
  else
    self.vx, self.vy = 0, 0
  end

  return self
end

function Bullet:update(dt)
  self.x = self.x + self.vx * dt
  self.y = self.y + self.vy * dt

  if self.life <= 0 then
    self.removal = true
  else
    self.life = self.life - dt
  end
end

function Bullet:draw()
  love.graphics.setColor(1, 0.8, 0.2)
  love.graphics.circle("fill", self.x, self.y, self.radius)
end

function Bullet:hit()
  self.removal = true
end

return Bullet
