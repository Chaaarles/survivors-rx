local Config = require "config"

local Bullet = {}
Bullet.__index = Bullet

function Bullet.new(x, y, xVel, yVel)
  local self = setmetatable({}, Bullet)
  self.id = NewId()
  self.bullet = true
  self.pos = { x = x, y = y }
  self.vel = { x = xVel, y = yVel }
  self.lifeTime = Config.bullet.life
  self.collider = { type = "circle", radius = Config.bullet.radius, tag = "bullet" }
  return self
end

function Bullet:draw()
  love.graphics.setColor(0.1, 0.1, 0.1)
  love.graphics.setLineWidth(6)
  love.graphics.setLineStyle("rough")
  love.graphics.circle('line', self.pos.x, self.pos.y, self.collider.radius)
  love.graphics.setColor(1, 1, 0)
  love.graphics.circle("fill", self.pos.x, self.pos.y, self.collider.radius)
end

return Bullet
