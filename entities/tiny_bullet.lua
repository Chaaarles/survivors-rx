local Config = require "config"

local Bullet = {}
Bullet.__index = Bullet

function Bullet.new(x, y, angle)
  local self = setmetatable({}, Bullet)
  self.bullet = true
  self.pos = { x = x, y = y }
  self.vel = { x = math.cos(angle) * Config.bullet.speed, y = math.sin(angle) * Config.bullet.speed }
  self.lifeTime = Config.bullet.life
  self.collider = { type = "circle", radius = Config.bullet.radius, tag = "bullet" }
  return self
end

function Bullet:draw()
  love.graphics.setColor(1, 0.8, 0)
  love.graphics.circle("fill", self.pos.x, self.pos.y, self.collider.radius)
end

return Bullet
